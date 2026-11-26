
# Étape 1 : Construction avec Maven et Java 17
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .
COPY .mvn .mvn
COPY mvnw .

RUN chmod +x mvnw

COPY src ./src

RUN ./mvnw clean package -DskipTests

# Étape 2 : Exécution avec Java 17
FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=build /app/target/backend-1.0.0.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
