# Introduction

This project packages Apache Tomcat 8.0.36 artifacts with SpringBoot 1.4.1.RELEASE.


# Launch

     mvn spring-boot:run

# Test

* We can access the REST endpoint using curl or httpie tool
```
http http://localhost:8080/greeting
curl http://localhost:8080/greeting
```