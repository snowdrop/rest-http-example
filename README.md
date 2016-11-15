# Introduction

This project packages Apache Tomcat 8.0.36 artifacts with SpringBoot 1.4.1.RELEASE. It can be used with the Apache Tomcat Red Hat Jar or the files
proposed by the Apache Tomcat Community project. The by default profile will use the Red Hat jar files but you can also make a test using the community files

```
mvn clean install -Predhat (default profile)
```

```
mvn clean install -Pcommunity
```


# Launch
```
mvn spring-boot:run
```

# Test

* We can access the REST endpoint using curl or httpie tool
```
http http://localhost:8080/greeting
curl http://localhost:8080/greeting
```
