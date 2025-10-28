```dockerfile
# Stage 1: Build
FROM maven:3.8-jdk-11 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:resolve -Bq!

# Copy source code
COPY . .

# Install dependencies
RUN mvn install -DskipTests

# Create artifact
RUN mvn package -Dmaven.test.skip=true

# Stage 2: Runtime
FROM openjdk:11-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/your-app.jar .
EXPOSE 8080
CMD ["java", "-jar", "your-app.jar"]
```