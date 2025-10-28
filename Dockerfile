```dockerfile
# Stage 1: Build
FROM openjdk:11 AS build-env
WORKDIR /app
COPY src /app/src
COPY pom.xml .

RUN mvn clean package -Dmaven.test.skip=true

# Stage 2: Runtime
FROM openjdk:11-jdk-alpine
WORKDIR /app
COPY --from=build-env /app/target/* /app/
CMD ["java","-jar","*.jar"]
```