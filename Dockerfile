```
# Use official Python image as base, specifically the latest 3.x version
FROM python:latest as builder

# Set working directory in container /app
WORKDIR /app

# Copy requirements file from current directory and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code from current directory into the container at /app
COPY . .

# Build the static files if needed, or use a separate build step for it
RUN python -m compileall .

# Use multi-stage build to create final image with only production dependencies
FROM python:latest as runner
WORKDIR /app

# Copy the application code from the builder stage
COPY --from=builder /app .

# Expose port 80 for the container
EXPOSE 80

# Run command when container launches
CMD ["python", "main.py"]
```