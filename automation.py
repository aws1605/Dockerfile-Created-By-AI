import ollama
import os
import shutil
from git import Repo

PROMPT = """
ONLY Generate an ideal Dockerfile for {language} with best practices.
Include:
- Base image
- Installing dependencies
- Setting working directory
- Adding source code
- Running the application
- multi stage docker build
"""

# === Step 1: Ask for user input ===
language = input("Enter the programming language: ").strip().lower()

# === Step 2: Generate Dockerfile content ===
response = ollama.chat(model='llama3', messages=[{"role": "user", "content": PROMPT.format(language=language)}])
dockerfile_content = response['message']['content']

# === Step 3: Define file/folder paths ===
repo_path = r"C:\Users\Dipank\Desktop\Github-Actions"  # change this to your repo path
docker_folder = os.path.join(repo_path, "docker_files")
docker_file_path = os.path.join(docker_folder, "Dockerfile")

# === Step 4: Delete old folder and create a new one ===
if os.path.exists(docker_folder):
    shutil.rmtree(docker_folder)
os.makedirs(docker_folder)

# === Step 5: Save new Dockerfile ===
with open(docker_file_path, "w") as f:
    f.write(dockerfile_content)
print(f"✅ New Dockerfile created for {language}")

# === Step 6: Push changes to GitHub ===
repo = Repo(repo_path)
repo.git.add(A=True)
repo.index.commit(f"Updated Dockerfile for {language}")
origin = repo.remote(name='origin')
origin.push()
print("🚀 Changes pushed to GitHub successfully!")
