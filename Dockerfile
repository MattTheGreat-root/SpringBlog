# Use Eclipse Temurin OpenJDK 17 (LTS) for building.
# 'jammy' refers to Ubuntu 22.04 LTS, providing a stable and widely available base.
FROM eclipse-temurin:17-jdk-jammy as builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven build files and source code
COPY pom.xml .
COPY src ./src/

# Use Maven Wrapper to build the application into a JAR
# The -DskipTests flag skips running tests, which speeds up the build process.
RUN ./mvnw clean package -DskipTests

# --- Second stage: Create a smaller image for running the application ---
# Use Eclipse Temurin OpenJDK 17 JRE for running.
FROM eclipse-temurin:17-jre-jammy

# Set the working directory in the runtime container
WORKDIR /app

# Copy the built JAR file from the 'builder' stage
# IMPORTANT: 'blog-0.0.1-SNAPSHOT.jar' is the correct name from your project's target/ folder.
COPY --from=builder /app/target/blog-0.0.1-SNAPSHOT.jar app.jar

# Expose the port your Spring Boot app runs on (10000)
EXPOSE 10000

# Command to run the application when the container starts
ENTRYPOINT ["java", "-jar", "app.jar"]