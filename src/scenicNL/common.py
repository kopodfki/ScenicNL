from enum import Enum
import json
import os
from pathlib import Path
import random
from dataclasses import dataclass
from typing import Any, Dict, Iterable, List, Optional, Union, Callable

from transformers import AutoTokenizer, AutoModel
import torch

from pinecone import Pinecone, ServerlessSpec

MAX_TOKEN_LENGTH = 3600
DISCUSSION_TEMPERATURE = 0.8
NUM_EXPERTS = 3


class LLMPromptType(Enum):
    PREDICT_ZERO_SHOT = "predict_zero_shot"
    PREDICT_FEW_SHOT = "predict_few_shot"
    PREDICT_SCENIC_TUTORIAL = "predict_scenic_tutorial"
    PREDICT_PYTHON_API = "predict_python_api"
    PREDICT_PYTHON_API_ONELINE = "predict_python_api_oneline"
    PREDICT_LMQL = "predict_lmql"
    PREDICT_FEW_SHOT_WITH_RAG = "predict_few_shot_with_rag"
    PREDICT_FEW_SHOT_WITH_HYDE = "predict_few_shot_with_hyde"
    PREDICT_FEW_SHOT_WITH_HYDE_TOT = "predict_few_shot_with_hyde_tot"
    PREDICT_TOT_THEN_HYDE = "predict_tot_then_hyde"
    PREDICT_TOT_THEN_SPLIT = "predict_tot_then_split"
    PREDICT_TOT_INTO_NL = "predict_tot_into_nl"
    EXPERT_DISCUSSION = "expert_discussion"
    EXPERT_SYNTHESIS = "expert_synthesis"
    AST_FEEDBACK = "ast_feedback"
    PREDICT_LMQL_TO_HYDE = 'predict_lmql_to_hyde'
    PREDICT_LMQL_RETRY = 'predict_lmql_retry'
    PREDICT_LMQL_TOT_RETRY = 'predict_lmql_tot_retry'


@dataclass(frozen=True)
class ModelInput:
    examples: list[str]
    nat_lang_scene_des: str
    first_attempt_scenic_program: Optional[str] = None
    compiler_error: Optional[str] = None
    expert_discussion: Optional[str] = None
    panel_discussion: Optional[List[str]] = None
    tot_reasoning: Optional[bool] = False

    def set_nl(self, nat_lang_scene_des):
        object.__setattr__(self, 'nat_lang_scene_des', nat_lang_scene_des)

    def set_exs(self, examples):
        object.__setattr__(self, 'examples', examples)

    def set_fasp(self, first_attempt_scenic_program):
        object.__setattr__(self, 'first_attempt_scenic_program', first_attempt_scenic_program)

    def set_err(self, compiler_error):
        object.__setattr__(self, 'compiler_error', compiler_error)

    def set_tot(self, tot_reasoning):
        object.__setattr__(self, 'tot_reasoning', tot_reasoning)


# ====================== Prompt utilities =====================

class PromptFiles(Enum):
    PROMPT_PATH = os.path.join(os.curdir, 'src', 'scenicNL', 'adapters', 'prompts')
    DISCUSSION_TO_PROGRAM = os.path.join(PROMPT_PATH, 'discussion_to_program.txt')
    DYNAMIC_SCENARIOS = os.path.join(PROMPT_PATH, 'dynamic_scenarios_prompt.txt')
    PYTHON_API = os.path.join(PROMPT_PATH, 'python_api_prompt.txt')
    QUESTION_REASONING = os.path.join(PROMPT_PATH, 'question_reasoning.txt')
    SCENIC_TUTORIAL = os.path.join(PROMPT_PATH, 'scenic_tutorial_prompt.txt')
    TOT_EXPERT_DISCUSSION = os.path.join(PROMPT_PATH, 'tot_questions.txt')
    EXPERT_SYNTHESIS = os.path.join(PROMPT_PATH, 'expert_synthesis.txt')
    AST_FEEDBACK_CLAUDE = os.path.join(PROMPT_PATH, 'few_shot_ast.txt')
    TOT_SPLIT = os.path.join(PROMPT_PATH, 'tot_split.txt')
    TOT_NL = os.path.join(PROMPT_PATH, 'tot_nl.txt')


def format_scenic_tutorial_prompt() -> str:
    with open(PromptFiles.SCENIC_TUTORIAL.value) as f:
        return f.read()

def format_reasoning_prompt(model_input: ModelInput) -> str:
    with open(PromptFiles.QUESTION_REASONING.value) as f:
        st_prompt = f.read()
    return st_prompt.format(
        example_1=model_input.examples[0],
        example_2=model_input.examples[1],
        example_3=model_input.examples[2],
        natural_language_description=model_input.nat_lang_scene_des
    )

def get_discussion_prompt() -> str:
    with open(PromptFiles.TOT_EXPERT_DISCUSSION.value) as f:
        return f.read()

def get_expert_synthesis_prompt() -> str:
    with open(PromptFiles.EXPERT_SYNTHESIS.value) as f:
        return f.read()

def get_discussion_to_program_prompt() -> str:
    with open(PromptFiles.DISCUSSION_TO_PROGRAM.value) as f:
        return f.read()

def get_few_shot_ast_prompt(model_input) -> str:
    with open(PromptFiles.AST_FEEDBACK_CLAUDE.value) as f:
        prompt = f.read()
    return prompt.format(
        natural_language_description=model_input.nat_lang_scene_des,
        example_1=model_input.examples[0],
        example_2=model_input.examples[1],
        example_3=model_input.examples[2],
        expert_discussion=model_input.expert_discussion,
        first_attempt_scenic_program=model_input.first_attempt_scenic_program,
        compiler_error=model_input.compiler_error
    )

def get_tot_nl_prompt(model_input) -> str:
    with open(PromptFiles.TOT_NL.value) as f:
        prompt = f.read()
    return prompt.format(
        natural_language_description=model_input.nat_lang_scene_des,
        expert_discussion=model_input.expert_discussion,
        panel_discussion=model_input.panel_discussion
    )


# ====================== Dataset I/O =====================

def load_jsonl(dataset_path: Path, *, max_examples: Optional[int]) -> Iterable[Dict[Any, Any]]:
    n_yielded = 0
    with dataset_path.open() as lines:
        for line in lines:
            if max_examples is not None and n_yielded >= max_examples:
                break
            line = line.strip()
            if not line:
                continue
            yield json.loads(line)
            n_yielded += 1

def write_jsonl(output_path: Path, data: Iterable[Dict[Any, Any]], *, shuffle_seed: Optional[int]) -> None:
    output_path.parent.mkdir(parents=True, exist_ok=True)
    if shuffle_seed is not None:
        data = list(data)
        random.Random(shuffle_seed).shuffle(data)
    with output_path.open("w") as output_file:
        for idx, example in enumerate(data):
            if idx > 0:
                output_file.write("\n")
            json.dump(example, output_file)


# ====================== Vector Store =====================

class VectorDB():
    def __init__(self,
                 index_name: str = 'scenic-programs',
                 model_name: str = 'sentence-transformers/all-mpnet-base-v2',
                 dimension: int = 768,
                 verbose: bool = False):
        self.device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')
        self.model_name = model_name
        self.tokenizer = AutoTokenizer.from_pretrained(self.model_name)
        self.model = AutoModel.from_pretrained(self.model_name).to(self.device)

        self.pc = self._pinecone_init(index_name, dimension)
        self.index = self.pc.Index(index_name)

        if verbose:
            print(f"Index statistics: \n{self.index.describe_index_stats()}")

    def _pinecone_init(self, index_name: str, dimension: int):
        api_key = os.getenv('PINECONE_API_KEY')
        environment = os.getenv('PINECONE_ENVIRONMENT')  # usually "us-east-1"
        cloud = os.getenv('PINECONE_CLOUD', 'aws')

        pc = Pinecone(api_key=api_key)

        indexes = pc.list_indexes().names()

        if index_name not in indexes:
            pc.create_index(
                name=index_name,
                dimension=dimension,
                metric='dotproduct',
                spec=ServerlessSpec(cloud=cloud, region=environment)
            )

        return pc

    def _mean_pooling(self, model_output, attention_mask) -> torch.Tensor:
        token_embeddings = model_output[0]
        input_mask_expanded = attention_mask.unsqueeze(-1).expand(token_embeddings.size()).float()
        return torch.sum(token_embeddings * input_mask_expanded, 1) / torch.clamp(input_mask_expanded.sum(1), min=1e-9)

    def get_embedding(self, text: str) -> List[float]:
        encoded_input = self.tokenizer(text, padding=True, truncation=True, return_tensors='pt').to(self.device)
        with torch.no_grad():
            model_output = self.model(**encoded_input)
        embeddings = self._mean_pooling(model_output, encoded_input['attention_mask'])
        normalized_embeddings = torch.nn.functional.normalize(embeddings, p=2, dim=1)
        return normalized_embeddings.cpu().numpy().tolist()[0]

    def upsert(self, docs: list, start: int = 0):
        vectors = []
        for i, doc in enumerate(docs):
            id_batch = str(i + start)
            embedding = self.get_embedding(doc)
            metadata = {'text': doc}
            vectors.append((id_batch, embedding, metadata))
        if vectors:
            self.index.upsert(vectors)

    def query(self, query_or_queries: Union[str, List[str]], top_k: int = 3) -> Optional[List[str]]:
        if isinstance(query_or_queries, str):
            query_or_queries = [query_or_queries]
        query_embeddings = [self.get_embedding(query) for query in query_or_queries]
        results_dict = self.index.query(query_embeddings, top_k=top_k, include_metadata=True)
        passages = [result['metadata']['text'] for result in results_dict['matches']]
        if len(passages) < top_k:
            return None
        return passages


def few_shot_prompt_with_rag(
    vector_index: VectorDB,
    model_input: ModelInput,
    few_shot_prompt_generator: Callable[[ModelInput, bool], Union[List[Dict[str, str]], str]],
    top_k: int = 3,
) -> Union[str, List[Dict[str, str]]]:
    examples = vector_index.query(model_input.nat_lang_scene_des, top_k=top_k)
    if examples is None:
        return few_shot_prompt_generator(model_input, False)
    relevant_model_input = ModelInput(examples=examples, nat_lang_scene_des=model_input.nat_lang_scene_des)
    return few_shot_prompt_generator(relevant_model_input, False)

def query_with_rag(
    vector_index: VectorDB,
    nat_lang_scene_des: str,
    top_k: int = 3
) -> List[Dict[str, str]]:
    examples = vector_index.query(nat_lang_scene_des, top_k=top_k)
    return examples