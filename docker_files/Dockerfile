Here is an ideal Dockerfile for a Java application that follows best practices:

```dockerfile
# Use an official OpenJDK 11 image as our base image
FROM AdoptOpenJDK/openjdk-11:alpine

# Set the working directory in the container to /app
WORKDIR /app

# Copy the required files
COPY pom.xml .
COPY src/ .

# Install dependencies using Maven
RUN mvn dependency:go-offline -Dmaven.test.skip=true

# Build the JAR file
RUN mvn package -Dmaven.test.skip=true

# Create a new layer for the final image
FROM openjdk:11-jre-alpine

# Set the working directory in the container to /app
WORKDIR /app

# Copy the JAR file into the final image
COPY target/*.jar .

# Expose the port that the application runs on
EXPOSE 8080

# Run the command to start the Java application
CMD ["java", "-jar", "target/my-app.jar"]
```

Here's a breakdown of this Dockerfile:

1. **Base Image**: We use an official OpenJDK 11 image as our base image, which includes all the necessary dependencies for running Java applications.

2. **Working Directory**: We set the working directory in the container to `/app`, where we will copy our source code and pom.xml file later.

3. **Copying Files**: We copy our `pom.xml` and `src/` directories into the Docker image. This allows Maven to build our project.

4. **Installing Dependencies**: We use Maven to install all the necessary dependencies for our project, including the ones specified in the `pom.xml` file. The `-Dmaven.test.skip=true` flag tells Maven to skip running tests during the build process.

5. **Building the JAR File**: After installing dependencies, we use Maven to build a JAR file that contains our application's code.

6. **Multi-Stage Build**: We then switch to another stage (the second `FROM` instruction) where we create a minimal image based on OpenJDK 11 and expose port 8080 for the application to run on.

7. **Copying the JAR File**: In this final stage, we copy our built JAR file into the Docker image so that it can be executed when the container starts.

8. **Running the Application**: Finally, we use a `CMD` instruction to specify the command to start our Java application: running the JAR file using `java -jar`. This will start our application when the Docker container is run with the `-d` flag (which runs the container in detached mode) or when we use the `docker run` command.