Here is a sample Dockerfile that follows best practices for building a Java-based container:

```Dockerfile
# Base image: Use an official OpenJDK image
FROM openjdk:8-jdk-alpine

# Set working directory
WORKDIR /app

# Install dependencies (Maven, in this case)
RUN apk add --no-cache maven && \
    mvn dependency:get -DincludeScope=compile -DdownloadOnly=true -DartifactId=<your-artifact-id> -DgroupId=<your-group-id> -Dversion=<your-version>

# Copy your application source code
COPY src /app/src

# Compile and package the application (Maven, in this case)
RUN mvn clean package -Dmaven.test.skip=true

# Create a new stage for production
FROM openjdk:8-jre-alpine

# Set working directory (same as previous stage)
WORKDIR /app

# Copy the packaged application from previous stage
COPY --from=build /app/target/<your-artifact-id>-<your-version>.jar /app/

# Run the application with a command (e.g., `java -jar`)
CMD ["java", "-jar", "your-application.jar"]
```

Let's break down this Dockerfile:

1.  **Base Image**: We start with an official OpenJDK image (`openjdk:8-jdk-alpine`) for Java 8.
2.  **Working Directory**: Set the working directory to `/app` using `WORKDIR`.
3.  **Installing Dependencies**: Install Maven (and its dependencies) using `apk add`. This allows us to download and manage our project's dependencies using Maven.
4.  **Adding Source Code**: Copy your Java source code from the local file system into the container using `COPY`. In this example, we're copying the `src` directory.
5.  **Compiling and Packaging**: Run Maven (`mvn`) to compile and package your application. We skip testing using `-Dmaven.test.skip=true`.
6.  **Multi-Stage Docker Build**: Create a new stage for production using `FROM openjdk:8-jre-alpine`. This stage uses the same OpenJDK image but with only the JRE (Java Runtime Environment) included.
7.  **Copying Packaged Application**: Copy the packaged application from the previous stage to this one using `COPY --from=build`.
8.  **Running the Application**: Set the command for running the application using `CMD`. In this example, we're using `java -jar` to run a JAR file.

Note:

*   Replace `<your-artifact-id>`, `<your-group-id>`, and `<your-version>` with your actual Maven artifact ID, group ID, and version.
*   Update the command in the last stage to match how you want to run your application.