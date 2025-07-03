path = r"C:\git-shadow\ScenicNL"
import os

for root, dirs, files in os.walk(path):
    for file in files:
        if file.endswith(".py"):
            with open(os.path.join(root, file), "rb") as f:
                data = f.read()
                if b"\x85" in data:
                    print(f"FOUND 0x85 in: {os.path.join(root, file)}")
