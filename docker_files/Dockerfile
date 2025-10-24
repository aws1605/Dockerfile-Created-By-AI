Here is an ideal Dockerfile for Python with best practices:

```
# Use an official Python runtime as our base image
FROM python:3.9-slim-buster

# Set the working directory in the container to /app
WORKDIR /app

# Install dependencies from pip requirements file
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code into the container
COPY . .

# Multi-stage build: use a smaller base image for production and use it as our final stage
FROM python:3.9-slim-buster as prod-image

# Install dependencies in the production image
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code into the production image
COPY . .

# Set the working directory in the production image to /app
WORKDIR /app

# Run the application in the production image
CMD ["python", "your_app.py"]
```

Let me explain what each line does:

* `FROM python:3.9-slim-buster`: We use an official Python 3.9 runtime as our base image, which is a slimmed-down version that includes only the essential dependencies.
* `WORKDIR /app`: We set the working directory in the container to `/app`, where our application code will be located.
* `COPY requirements.txt .`: We copy our `requirements.txt` file into the container, which specifies the Python packages required by our application.
* `RUN pip install --no-cache-dir -r requirements.txt`: We use the `pip` package manager to install the dependencies specified in `requirements.txt`. The `--no-cache-dir` flag tells `pip` not to cache the installation, which can help reduce the size of the resulting image.
* `COPY . .`: We copy our source code into the container. This assumes that your application code is located in the same directory as the Dockerfile.
* `FROM python:3.9-slim-buster as prod-image`: We use a smaller base image (again, Python 3.9) for the production stage of our build. This will help reduce the size of our final image.
* The rest of the file is similar to the first part, but with some additional steps:
	+ `COPY requirements.txt .` and `RUN pip install ...`: We copy `requirements.txt` into the production image and install the dependencies.
	+ `COPY . .`: We copy our source code into the production image.
	+ `WORKDIR /app`: We set the working directory in the production image to `/app`.
	+ `CMD ["python", "your_app.py"]`: We specify the command to run when the container is started. In this case, we're running a Python script called `your_app.py`. Replace this with your actual application entry point.

By using a multi-stage build, we can create a smaller final image that only includes the dependencies and code required for our application to run. This can help reduce the size of our Docker images and make them easier to manage.