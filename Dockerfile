# Use a base image with Java and Maven installed
FROM maven:3.8.3-openjdk-17-slim AS build

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project files for dependencies
COPY pom.xml .

# Fetch dependencies
RUN mvn dependency:go-offline

# Copy the application source code
COPY src ./src

# Build the application
RUN mvn clean package

# Use a lightweight base image for the final image
FROM penjdk:17-jdk-slim AS runtime

# Set the working directory
WORKDIR /app

# Copy the built artifact from the build image to the runtime image
COPY --from=build /app/target/your-app.jar ./app.jar

# Set the command to run the application
CMD ["java", "-jar", "app.jar"]
