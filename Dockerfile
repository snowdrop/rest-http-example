FROM openjdk:11
COPY target/*.jar rest-http.jar
CMD java ${JAVA_OPTS} -jar rest-http.jar
