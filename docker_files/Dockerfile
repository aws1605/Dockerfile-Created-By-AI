Here is an ideal Dockerfile for a Java application that follows best practices:

```Dockerfile
# Use an official OpenJDK 11 image as the base
FROM openjdk:11-jdk-slim AS builder

# Set the working directory in the container
WORKDIR /app

# Copy the source code into the container
COPY pom.xml ./

# Install dependencies with Maven
RUN mvn dependency:go-offline -Dmaven.repo.local=/tmp/m2

# Set the working directory again to prevent issues with the next command
WORKDIR /app

# Build the application with Maven
RUN mvn package -Dmaven.repo.local=/tmp/m2

# Create a new image with only the runtime dependencies
FROM openjdk:11-jdk-slim AS runtime

# Set the working directory in the container again
WORKDIR /app

# Copy the compiled code into the new image
COPY target/ ./

# Run the application
CMD ["java", "-jar", "target/app.jar"]
```

This Dockerfile uses a multi-stage build to create an efficient and scalable image. Here's what each section does:

1. The first stage (builder) is based on openjdk:11-jdk-slim, which provides OpenJDK 11 with the `maven` package manager.
2. The working directory is set to `/app`, and the source code is copied into the container.
3. Maven dependencies are installed using the `mvn dependency:go-offline` command.
4. The working directory is set again to prevent issues with the next command.
5. The application is built using Maven with the `mvn package` command.
6. The second stage (runtime) is based on openjdk:11-jdk-slim, which provides OpenJDK 11 without Maven.
7. The compiled code is copied from the target directory into the new image.
8. The application is run using the `java` command with the `-jar` option to specify the main class.

Best practices followed:

* Using official OpenJDK images for Java and Maven
* Setting the working directory consistently throughout the build process
* Installing dependencies offline to reduce network I/O during the build
* Building the application in a separate stage to prevent unnecessary dependencies from being included in the final image
* Running the application using the `java` command with the `-jar` option to specify the main class