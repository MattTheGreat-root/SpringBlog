# Use Eclipse Temurin OpenJDK 17 (LTS) for building.
FROM eclipse-temurin:17-jdk-jammy as builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven Wrapper scripts and pom.xml first
# This is crucial for './mvnw' to be found and executable.
COPY mvnw .
COPY mvnw.cmd . 
COPY pom.xml .
COPY src ./src/

# Make the Maven Wrapper script executable
RUN chmod +x mvnw

# Use Maven Wrapper to build the application into a JAR
RUN ./mvnw clean package -DskipTests

# --- Second stage: Create a smaller image for running the application ---
FROM eclipse-temurin:17-jre-jammy

# Set the working directory in the runtime container
WORKDIR /app

# Copy the built JAR file from the 'builder' stage
COPY --from=builder /app/target/blog-0.0.1-SNAPSHOT.jar app.jar

# Expose the port your Spring Boot app runs on (10000)
EXPOSE 10000

# Command to run the application when the container starts
ENTRYPOINT ["java", "-jar", "app.jar"]