#FROM java:8
FROM frolvlad/alpine-oraclejdk8:slim
EXPOSE 8090
VOLUME /tmp
ADD target/spring-boot-rest-0.3.0.jar app.jar
RUN bash -c  'touch /app.jar'
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-Dspring.profiles.active=container","-jar","/app.jar"]
#ENTRYPOINT ["java","-jar","-Xms256m", "-Xmx512m","/hello-world.jar"]
