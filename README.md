# Introduction

This project packages Apache Tomcat 8.0.36 artifacts with SpringBoot 1.4.1.RELEASE. It can be used with the Apache Tomcat Red Hat Jar files or the files
packaged with the Apache Tomcat Community project. the by drfault profile will use the Red Hat jar files but you can also make a test using the community files

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

# Use Red Hat jar files

Since JWS-3.1 ER4 we have embedded jar for tomcat-8.0.36 and a sort of maven repo (location at the moment: http://download-node-02.eng.bos.redhat.com/brewroot/repos/jws-3.1-rhel-7-build/latest/maven ).
In order to be able to run a Spring Boot / JWS Tomcat application you need to do the following:


1 - Add the brew repo to your Maven settings.xml:
	<!-- Red Hat repo here... -->
    	<repository>
      	<id>redhatbuilds</id>
      	<name>RED Hat builds Repository</name>
      	<url>http://download-node-02.eng.bos.redhat.com/brewroot/repos/jws-3.1-rhel-7-build/latest/maven/</url>
      	<layout>default</layout>
      	<releases>
        	<enabled>true</enabled>
        	<updatePolicy>never</updatePolicy>
      	</releases>
      	<snapshots>
        	<enabled>false</enabled>
      	</snapshots>
    	</repository>
OR add the repository in the pom.xml of the project:
<repositories>
  	<repository>
  	  <id>jws31</id>
  	  <name>JWS 3.1 Repository</name>
                  <url>http://download-node-02.eng.bos.redhat.com/brewroot/repos/jws-3.1-rhel-7-build/latest/maven</url>
 	</repository>
 	</repositories>


Note the repository will be moved to an official location later, our production will be complete.


2 - Add the version of JWS Tomcat in the pom.xml of the application, for example:
            <tomcat.version>8.0.36.redhat-14</tomcat.version>
OR specify the JWS Tomcat version on the command line:
mvn -Dtomcat.version=8.0.36.redhat-14 spring-boot:run	
