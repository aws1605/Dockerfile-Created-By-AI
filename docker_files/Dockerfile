Here's a sample Dockerfile that follows best practices for building a Java application:

```
# Base Image
FROM openjdk:8-jdk-alpine as builder

# Set working directory
WORKDIR /app

# Install dependencies (Maven in this case)
RUN mvn -version && \
    apk add --no-cache maven3

# Copy the source code
COPY pom.xml .

# Download Maven dependencies
RUN mvn package -Dmaven.test.skip=true

# Create a new image for running the application
FROM openjdk:8-jre-alpine

# Set working directory (again)
WORKDIR /app

# Copy the compiled JAR file from the builder stage
COPY target/*.jar .

# Run the application
CMD ["java", "-jar", "app.jar"]
```

Let me explain what each section does:

1. `FROM openjdk:8-jdk-alpine as builder`: This sets up a new Docker image based on the OpenJDK 8 Java Development Kit (JDK) and Alpine Linux, which is a lightweight distribution. We're using the `builder` stage to compile our application.

2. `WORKDIR /app`: This sets the working directory in the Docker image to `/app`.

3. `RUN mvn -version && apk add --no-cache maven3`: This installs Maven (a popular build tool for Java) and its dependencies. The `-version` command checks if Maven is installed, and the `apk add` command installs it.

4. `COPY pom.xml .`: This copies the Maven Project Object Model (POM) file into the Docker image.

5. `RUN mvn package -Dmaven.test.skip=true`: This compiles our Java application using Maven and ignores any tests that might be present in the POM file.

6. `FROM openjdk:8-jre-alpine`: This sets up a new Docker image based on OpenJDK 8 Runtime Environment (JRE) and Alpine Linux, which is another lightweight distribution. We're using this stage to run our application.

7. `WORKDIR /app`: Again, we set the working directory in the Docker image to `/app`.

8. `COPY target/*.jar .`: This copies the compiled JAR file from the builder stage into the running stage.

9. `CMD ["java", "-jar", "app.jar"]`: This runs our application using the Java command and specifies that the JAR file should be used.

This Dockerfile uses a multi-stage build, which allows us to separate our build process (compiling our application) from our runtime environment (running our application).