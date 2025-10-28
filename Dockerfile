```dockerfile
# Base image: Use a minimal base image to reduce the final image size
FROM maven:3.8-jdk-11 as builder

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project into the container at the specified path
COPY pom.xml .

# Build the application using Maven
RUN mvn clean package

# Add source code to the image, but don't compile it yet
COPY . .

# Use a separate base image for running Java applications
FROM openjdk:11-jdk-alpine as runner

# Set the working directory in the container
WORKDIR /app

# Copy the compiled application into the new image
COPY --from=builder /app/target/*.jar .

# Expose the default port
EXPOSE 8080

# Run the Java application when the container launches
CMD ["java", "-jar", "myapplication.jar"]
```