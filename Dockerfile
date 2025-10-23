```dockerfile
# Use a minimal base image to reduce size and improve security
FROM --platform=linux/amd64 python:3.9-slim-buster AS builder

# Set working directory to /app
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install -r requirements.txt --no-cache

# Copy source code
COPY . .

# Build the application (optional)
RUN python setup.py build

# Create production image with a minimal base image and layers for prod env
FROM python:3.9-slim-buster AS prod

# Set working directory to /app
WORKDIR /app

# Copy requirements file
COPY --from=builder requirements.txt .

# Install dependencies
RUN pip install -r requirements.txt --no-cache

# Copy source code
COPY --from=builder . .

# Run the application in production mode
CMD ["uwsgi", "uwsgi.ini"]
```