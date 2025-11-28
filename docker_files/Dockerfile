Here is an ideal Dockerfile for a Java application that follows best practices:

```Dockerfile
# Use an official OpenJDK 11 image as our base
FROM openjdk:11-jdk-slim AS builder

# Set the working directory in the container to /app
WORKDIR /app

# Copy the source code from the current directory into the container
COPY pom.xml .

# Install dependencies using Maven
RUN mvn -q clean package

# Create a new stage for the runtime environment
FROM openjdk:11-jdk-slim AS runtime

# Set the working directory in the container to /app
WORKDIR /app

# Copy the compiled application code from the builder stage into the runtime stage
COPY --from=builder target/*.jar .

# Run the application using the command 'java -jar'
CMD ["java", "-jar", "target/my-java-app.jar"]
```

Let's go through what each line does:

1. `FROM openjdk:11-jdk-slim AS builder`: This line uses an official OpenJDK 11 image as our base, and gives it the name `builder`. We'll use this stage to build our application.
2. `WORKDIR /app`: This line sets the working directory in the container to `/app`.
3. `COPY pom.xml .`: This line copies the `pom.xml` file from the current directory into the container at the specified location (`/app`). The `.` at the end means "copy this file into the same directory".
4. `RUN mvn -q clean package`: This line installs dependencies using Maven, with the `-q` flag to suppress output.
5. `FROM openjdk:11-jdk-slim AS runtime`: This line starts a new stage for our runtime environment, again using an official OpenJDK 11 image as our base, and gives it the name `runtime`. We'll use this stage to run our application.
6. `WORKDIR /app`: This line sets the working directory in the container to `/app`, just like we did earlier.
7. `COPY --from=builder target/*.jar .`: This line copies the compiled application code from the `builder` stage into the `runtime` stage, specifically looking for JAR files in the `target` directory and copying them into the current directory (`/app`).
8. `CMD ["java", "-jar", "target/my-java-app.jar"]`: This line sets the default command to run when we start a new container from this image. In this case, it runs the Java application using the command `java -jar`, with the name of the JAR file (`my-java-app.jar`) as an argument.

By using a multi-stage build, we can keep our dependencies and compiled code separate, which makes it easier to maintain and update our Docker image.