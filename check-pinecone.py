import scenicNL, inspect, os, pinecone
from scenicNL.common import VectorDB

print("VectorDB loaded from:", inspect.getfile(VectorDB))
db = VectorDB(dimension=768, verbose=True)   # will print index stats if everything lines up