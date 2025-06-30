# Use a base image with Java 21 (as per your pom.xml)
# 'openjdk:21-jdk' provides the JDK for building. This is a more general tag.
FROM openjdk:21-jdk as builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven build files and source code
# Since you're using Maven (from pom.xml), we copy pom.xml and the src directory.
COPY pom.xml .
COPY src ./src/

# Use Maven Wrapper to build the application into a JAR
# The -DskipTests flag skips running tests, which speeds up the build process.
RUN ./mvnw clean package -DskipTests

# --- Second stage: Create a smaller image for running the application ---
# 'openjdk:21-jre' provides just the JRE for running, making the final image smaller.
FROM openjdk:21-jre

# Set the working directory in the runtime container
WORKDIR /app

# Copy the built JAR file from the 'builder' stage
# IMPORTANT: Replace 'blog-0.0.1-SNAPSHOT.jar' with the ACTUAL name of your JAR file.
# You can find this name in your local 'target/' directory after running 'mvn clean package'.
COPY --from=builder /app/target/blog-0.0.1-SNAPSHOT.jar app.jar

# Expose the port your Spring Boot app runs on.
# You confirmed your app uses port 10000, so we expose that.
EXPOSE 10000

# Command to run the application when the container starts
# 'java -jar app.jar' starts your Spring Boot application.
ENTRYPOINT ["java", "-jar", "app.jar"]