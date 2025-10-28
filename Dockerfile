```
# Stage 1: Build
FROM maven:3.6.0-jdk8 AS builder
WORKDIR /app

# Set environment variables
ENV MAVEN_OPTS -Xmx512m

# Copy dependencies
COPY pom.xml .
RUN mvn dependency:resolve -B

# Copy source code
COPY src/main/java /app/src/main/java
COPY src/main/resources /app/src/main/resources

# Build the project
RUN mvn clean package -B

# Stage 2: Runtime
FROM openjdk:8-jdk-alpine
WORKDIR /app

# Copy dependencies (only the executable JAR file)
COPY --from=builder /app/target/*.jar /app/

# Expose port
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "target/myapp.jar"]
```