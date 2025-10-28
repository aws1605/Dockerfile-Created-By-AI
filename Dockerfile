```dockerfile
# Use official Python base image
FROM python:3.9-slim-buster as builder

# Set environment variables for pip and virtual environment
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install dependencies
RUN pip install --upgrade pip
COPY requirements.txt .

RUN pip install -r requirements.txt

# Set working directory
WORKDIR /app

# Copy source code
COPY . .

# Build the application
RUN pip install -e .

# Multi-stage build for final image
FROM python:3.9-slim-buster

# Set environment variables for production server
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Copy dependencies and source code from previous stage
COPY --from=builder /app/requirements.txt .
COPY --from=builder /app .

# Expose the port
EXPOSE 8000

# Run the command to start the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```