# Use Eclipse Temurin OpenJDK 17 (LTS) for building.
FROM eclipse-temurin:17-jdk-jammy as builder

WORKDIR /app

COPY .mvn .mvn/
COPY mvnw .
COPY mvnw.cmd .
COPY pom.xml .
COPY src ./src/

RUN chmod +x mvnw

RUN ./mvnw clean package -DskipTests

FROM eclipse-temurin:17-jre-jammy

WORKDIR /app

# Copy the built JAR file from the 'builder' stage
COPY --from=builder /app/target/blog-0.0.1-SNAPSHOT.jar app.jar

# Expose the port your Spring Boot app runs on (10000)
EXPOSE 10000

ENTRYPOINT ["java", "-jar", "app.jar"]