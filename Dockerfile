# Use a base image with Java 17 (LTS)
FROM openjdk:17-jdk-slim as builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven build files and source code
COPY pom.xml .
COPY src ./src/

# Use Maven Wrapper to build the application into a JAR
RUN ./mvnw clean package -DskipTests

# --- Second stage: Create a smaller image for running the application ---
FROM openjdk:17-jre-slim

# Set the working directory in the runtime container
WORKDIR /app

# Copy the built JAR file from the 'builder' stage
# IMPORTANT: Ensure 'blog-0.0.1-SNAPSHOT.jar' is the correct name from your project's target/ folder.
COPY --from=builder /app/target/blog-0.0.1-SNAPSHOT.jar app.jar

# Expose the port your Spring Boot app runs on (10000)
EXPOSE 10000

# Command to run the application when the container starts
ENTRYPOINT ["java", "-jar", "app.jar"]