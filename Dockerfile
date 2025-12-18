#stage1 build
FROM maven:3.9.9-eclipse-temurin-17 AS builder
WORKDIR /opt/app
COPY . .
RUN mvn package 

#Stage2 runtime
FROM eclipse-temurin:17-jre-jammy
WORKDIR /opt/app
COPY --from=builder /opt/app/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
