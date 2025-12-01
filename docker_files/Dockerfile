Here is an ideal Dockerfile for a Java application that follows best practices:

```Dockerfile
# Use an official OpenJDK 11 image as the base image
FROM openjdk:11-jdk-slim AS builder

# Set the working directory in the container to /app
WORKDIR /app

# Copy the source code into the container
COPY pom.xml /app/
COPY src/main/java /app/src/main/java
COPY src/main/resources /app/src/main/resources
COPY target /app/target

# Install dependencies using Maven
RUN mvn -f /app/pom.xml package

# Create a new stage for the final image
FROM openjdk:11-jdk-slim AS runtime

# Set the working directory in the container to /app
WORKDIR /app

# Copy the compiled application code into the container
COPY --from=builder /app/target/classes /app/
COPY --from=builder /app/target/lib /app/

# Run the application using Java
CMD ["java", "-jar", "my-app.jar"]
```

Here's a brief explanation of each line:

1. `FROM openjdk:11-jdk-slim AS builder`: This line tells Docker to use an official OpenJDK 11 image as the base image for the build stage. The `AS` keyword gives the stage a name (`builder`) that can be used later in the Dockerfile.
2. `WORKDIR /app`: This line sets the working directory in the container to `/app`. This is where we'll copy our source code and install dependencies.
3. `COPY pom.xml /app/`: This line copies the `pom.xml` file from the current directory into the container at `/app`.
4. `COPY src/main/java /app/src/main/java`: This line copies the Java source code from the current directory into the container at `/app/src/main/java`.
5. `COPY src/main/resources /app/src/main/resources`: This line copies the resources (e.g., configuration files, images) from the current directory into the container at `/app/src/main/resources`.
6. `COPY target /app/target`: This line copies the compiled Java classes and other build artifacts from the current directory into the container at `/app/target`.
7. `RUN mvn -f /app/pom.xml package`: This line installs dependencies using Maven and compiles the Java code.
8. `FROM openjdk:11-jdk-slim AS runtime`: This line starts a new stage for the final image, again using an official OpenJDK 11 image as the base image.
9. `WORKDIR /app`: This line sets the working directory in the container to `/app`.
10. `COPY --from=builder /app/target/classes /app/`: This line copies the compiled Java classes from the build stage into the runtime stage.
11. `COPY --from=builder /app/target/lib /app/`: This line copies any dependent libraries or artifacts from the build stage into the runtime stage.
12. `CMD ["java", "-jar", "my-app.jar"]`: This line sets the default command to run when the container is started, which is to execute the Java application using the `-jar` option.

This Dockerfile uses a multi-stage build, where we have two stages: `builder` and `runtime`. The `builder` stage is used to compile the Java code and install dependencies, while the `runtime` stage is used to create the final image that can be run.