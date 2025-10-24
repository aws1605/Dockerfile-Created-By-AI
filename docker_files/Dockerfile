Here is an ideal Dockerfile for Python that follows best practices:

```dockerfile
# Use an official Python runtime as our base image
FROM python:3.9-slim-buster

# Set the working directory in the container to /app
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the current directory contents into the container at /app
COPY . .

# Define environment variable
ENV PYTHONDONTWRITEBYTECODE 1

# Run command when the container is run
CMD ["python", "main.py"]

# Multi-stage build for a faster and smaller image
FROM python:3.9-slim-buster as builder

WORKDIR /app

COPY requirements.txt .
COPY . .

RUN pip install -r requirements.txt

RUN python setup.py sdist && pip install dist/*.whl

FROM python:3.9-slim-buster

WORKDIR /app

COPY --from=builder /app/dist/* .

CMD ["python", "main.py"]
```

Here's an explanation of the Dockerfile:

1.  **Base Image**: The base image is `python:3.9-slim-buster`, which is an official Python runtime that comes with a set of pre-installed dependencies and tools.

2.  **Working Directory**: The working directory in the container is set to `/app` using the `WORKDIR` instruction.

3.  **Installing Dependencies**: The `requirements.txt` file is copied into the container, and then pip installs the dependencies listed in that file using the `pip install -r requirements.txt` command.

4.  **Adding Source Code**: The current directory's contents are copied into the container at `/app` using the `COPY . .` instruction.

5.  **Running the Application**: When the container is run, it will execute the command `python main.py`, where `main.py` is assumed to be the entry point of the application.

6.  **Multi-Stage Build**: The Dockerfile uses a multi-stage build, which allows for faster and smaller images. In this case, there are two stages:

    *   The first stage (`FROM python:3.9-slim-buster as builder`) is used to install dependencies and build the application.
    *   The second stage (`FROM python:3.9-slim-buster`) uses the artifacts from the first stage to create a smaller, production-ready image.

7.  **Copying Built Artifact**: In the second stage, the built artifact (the wheel file) is copied into the new image using `COPY --from=builder /app/dist/* .`.

8.  **CMD Command**: The `CMD` instruction specifies the command that should be executed when the container is run.