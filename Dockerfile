# Use Java 21 runtime
FROM eclipse-temurin:21-jre

# Application working directory
WORKDIR /app

# Copy Spring Boot executable JAR
COPY target/calculator-1.0.0.jar app.jar

# Expose application port
EXPOSE 8080

# Start the application
ENTRYPOINT ["java","-jar","app.jar"]