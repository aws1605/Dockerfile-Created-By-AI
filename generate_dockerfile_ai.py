import os
import subprocess
from datetime import datetime
import ollama

# === Step 1: Define the GenAI Prompt ===
PROMPT = """
ONLY Generate an ideal Dockerfile for {language} with best practices.
Do not provide any explanation or text outside Dockerfile.
Include:
- Base image
- Installing dependencies
- Setting working directory
- Adding source code
- Running the application
- Multi-stage Docker build
"""

# === Step 2: Function to generate Dockerfile content using Ollama ===
def generate_dockerfile(language):
    print(f"🤖 Generating Dockerfile for {language} using LLaMA3.1 model...")
    response = ollama.chat(
        model='llama3.1:8b',
        messages=[{'role': 'user', 'content': PROMPT.format(language=language)}]
    )
    # Extract the generated Dockerfile content
    dockerfile_content = response['message']['content']
    return dockerfile_content

# === Step 3: Main script logic ===
if __name__ == '__main__':
    # Ask developer for input language
    language = input("Enter the programming language: ").strip()

    # Remove old Dockerfile if it exists
    if os.path.exists("Dockerfile"):
        os.remove("Dockerfile")
        print("🧹 Old Dockerfile removed successfully.")

    # Generate new Dockerfile content
    dockerfile = generate_dockerfile(language)

    # Save to a new Dockerfile
    with open("Dockerfile", "w") as f:
        f.write(dockerfile)
    print("✅ New Dockerfile saved successfully.")

    # Display the Dockerfile
    print("\nGenerated Dockerfile Preview:\n")
    print(dockerfile)

    # === Step 4: Commit and Push to GitHub ===
    try:
        print("\n📦 Pushing changes to GitHub repository...\n")
        # Stage file
        subprocess.run(["git", "add", "Dockerfile"], check=True)
        
        # Commit with timestamp
        commit_msg = f"Auto-generated Dockerfile for {language.title()} ({datetime.now().strftime('%Y-%m-%d %H:%M:%S')})"
        subprocess.run(["git", "commit", "-m", commit_msg], check=True)
        
        # Push changes
        subprocess.run(["git", "push"], check=True)

        print("🚀 Dockerfile successfully pushed to GitHub!")
    except subprocess.CalledProcessError as e:
        print("⚠️ Git push failed. Please verify GitHub authentication or repository access.")
        print("Error details:", e)
