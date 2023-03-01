FROM eclipse-temurin:17-jdk-jammy as build

WORKDIR /opt/app

COPY .mvn .mvn
COPY mvnw .
COPY pom.xml .
COPY model/pom.xml model/pom.xml
COPY model/src model/src
COPY server/pom.xml server/pom.xml
COPY server/src server/src

RUN --mount=type=cache,target=/root/.m2,rw ./mvnw package -DskipTests

FROM eclipse-temurin:17-jre-jammy

COPY --from=build /opt/app/server/target/server-1.0-SNAPSHOT.jar server.jar

EXPOSE 9090

ENTRYPOINT ["java", "-jar", "server.jar"]
