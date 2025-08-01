# Multi-stage build pentru optimizare
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package spring-boot:repackage -DskipTests -B
FROM eclipse-temurin:17-jre-alpine AS runtime
RUN apk add --no-cache curl
RUN addgroup -g 1001 -S grm && \
    adduser -S grm -u 1001 -G grm

WORKDIR /app
RUN mkdir -p uploads logs && \
    chown -R grm:grm /app
COPY --from=build /app/target/*.jar app.jar
RUN chown grm:grm app.jar
USER grm
EXPOSE 8080
ENV JAVA_OPTS="-Xmx512m -Xms256m" \
    SPRING_PROFILES_ACTIVE=docker
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8080/actuator/health || exit 1
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
