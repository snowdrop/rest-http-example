# Introduction

This project packages Apache Tomcat 8.0.36 artifacts with SpringBoot 1.4.1.RELEASE. It can be used with the Apache Tomcat Red Hat Jar or the files
proposed by the Apache Tomcat Community project. The by default profile will use the Red Hat jar files but you can also make a test using the community files

```
mvn clean install -Predhat (default profile)
```

```
mvn clean install -Pcommunity
```

# OpenShift

Project can be build top of Openshift using minishift tool. For that purpose, you will use the profile `openshift` which has been 
configured to use the Fabric8 Maven plugin.

```
minishift start
minishift docker-env
oc login --user admin --password admin
mvn clean install -Popenshift -Predhat
```

Remark : To use the official Red Hat S2I image, then we must configure the Fabric8 Maven Plugin to use the Java S2I image with this parameter `-Dfabric8.generator.from=registry.access.redhat.com/jboss-fuse-6/fis-java-openshift`

Next we can deploy the POD and test it

```
mvn -Popenshift -Predhat fabric8:deploy
```

Then, you can test the service deployed in OpenShift and get a response message 

```
http $(minishift service rest --url=true)/greeting
```

To test the project against OpenShift using Arquillian, simply run this command

```
mvn test -Popenshift -Predhat
```

# Launch and test

To start Spring Boot using the embedded Aopache Tomcat jar files, run the following commands in order to start the maven goal of Spring Boot

```
mvn spring-boot:run
```

If the application has been launched without any error, you can access the REST endpoint exposed using curl or httpie tool

```
http http://localhost:8080/greeting
curl http://localhost:8080/greeting
```
