Blog Application
A simple blog application built with Spring Boot, Thymeleaf, and H2 Database.

✨ Features
Blog Post Management: Create, view, and display blog posts.

Thymeleaf Templates: Dynamic server-side rendering.

Embedded H2 Database: Lightweight, file-based database for local development.

Maven Build System: Standard project structure.

Dockerized: Ready to be run in a container.

Secure Configuration: Uses environment variables for sensitive data.

🚀 Technologies Used
Backend: Java 17, Spring Boot 3.x, Spring Data JPA, Thymeleaf

Database: H2 Database (file-based)

Build Tool: Apache Maven

Containerization: Docker

⚙️ Getting Started (Local)
Follow these steps to run the project on your local machine.

Prerequisites
Java Development Kit (JDK) 17 or higher

Apache Maven 3.6.0 or higher

Git

(Optional) Docker Desktop

1. Clone the Repository
git clone https://github.com/MattTheGreat-root/Blog.git
cd Blog

2. Configure Local Secret
Set the BLOG_SECRET environment variable in your terminal. Replace "your-local-dev-secret" with any string.

Linux/macOS:

export BLOG_SECRET="your-local-dev-secret"

Windows (Command Prompt):

set BLOG_SECRET="your-local-dev-secret"

Windows (PowerShell):

$env:BLOG_SECRET="your-local-dev-secret"

3. Build the Project
mvn clean package

4. Run the Application
java -jar target/blog-0.0.1-SNAPSHOT.jar

The application will start on http://localhost:10000.

5. Run with Docker (Local)
# Build the Docker image
docker build -t blog-app .

# Run the Docker container
docker run -p 10000:10000 -e BLOG_SECRET="your-docker-secret" blog-app

Access at http://localhost:10000.

💾 Data Persistence
This project uses an H2 file-based database. For data to persist across deployments on cloud platforms, you will need to configure a persistent disk for your web service (e.g., on a paid Render.com plan) and update spring.datasource.url in application.properties to point to the mounted disk path (e.g., jdbc:h2:file:/data/blogdb).
