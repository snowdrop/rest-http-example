# Introduction

This project exposes a simple REST endpoint where the service `greeting` is available at this address `http://hostname:port/greeting` and returns a json Greeting message

```
{
    "content": "Hello, World!",
    "id": 1
}

```

The id of the message is incremented for each request. To customize the message, you can pass as parameter the name of the person that you want to send your greeting.

# Build

The project bundles the Apache Tomcat 8.0.36 artifacts with SpringBoot 1.4.1.RELEASE. It can be used with the Apache Tomcat Red Hat Jar or the files
proposed by the Apache Tomcat Community project. The by default profile will use the Red Hat jar files but you can also make a test using the community files.

To build the project, use this maven command.

```
mvn clean install -Predhat (default profile)
```

or

```
mvn clean install -Pcommunity
```

# Launch and test

To start Spring Boot , run the following commands in order to start the maven goal of Spring Boot

```
mvn spring-boot:run
```

If the application has been launched without any error, you can access the REST endpoint exposed using curl or httpie tool

```
http http://localhost:8080/greeting
curl http://localhost:8080/greeting
```

To pass a parameter for the Greeting Service, use this HTTP request

```
http http://localhost:8080/greeting name==Charles
curl http://localhost:8080/greeting -d name=Bruno
```


# OpenShift

The Project can be deployed top of Openshift using the [minishift tool](https://github.com/minishift/minishift) who will take care to install within a Virtual machine (Virtualbox, libvirt or Xhyve) the OpenShift platform
like also a Docker daemon. For that purpose, you will first issue within a terminal the following commands.

```
minishift delete
minishift start --openshift-version=v1.3.1
eval $(minishift docker-env)
oc login --username=admin --password=admin
```

Next, we will use the Fabric8 Maven plugin which is a Java OpenShift/Kubernetes API able to communicate with the prlatform in order to request to build the docker image and next to create using Kubernetes
a pod from the image of our application.

A maven profile has been defined within this project to configure the Fabric8 Maven plugin

```
mvn clean fabric8:build -P redhat,openshift -DskipTests
```

Remark : To use the official Red Hat S2I image, then we must configure the Fabric8 Maven Plugin to use the Java S2I image with this parameter `-Dfabric8.generator.from=registry.access.redhat.com/jboss-fuse-6/fis-java-openshift`

Next we can deploy the templates top of OpenShift and wait till kubernetes has created the POD

```
mvn -Predhat,openshift fabric8:deploy -DskipTests
```

Then, you can test the service deployed in OpenShift and get a response message 

```
http $(minishift service springboot-rest --url=true)/greeting
```

To test the project against OpenShift using Arquillian, simply run this command

```
mvn test -Popenshift,redhat
```

# Using OpenShift Pipeline (optional)

In order to use the Pipleine Strategy supported by OpenShift for the build process, the server Jenkins should be installed. That should be
the case when you will use Openshift Enterprise. If this is not the case, please use the following instructions to install it

```
echo "Add the template containing Openshift Jenkins"
oc create -f https://raw.githubusercontent.com/openshift/origin/master/examples/jenkins/jenkins-ephemeral-template.json -n openshift

echo "Deploy Jenkins (without persistence)"
oc new-app jenkins-ephemeral
```

Remark : The login/password to be used to access the Jenkins Server is admin/password

Next we can build the project and deploy it on OpenShift using the profile `openshift-pipeline`.
 
```
mvn -Predhat,openshift-pipeline fabric8:deploy -DskipTests
```
 
During the fabric8 build process, a `BuildConfig` file will be created
containing the description of the Jenkins script to be executed within a job.

```
node('master') {
  stage 'build'
  openshiftBuild(buildConfig: 'rest-s2i', showBuildLogs: 'true')
  stage 'deploy'
  openshiftDeploy(deploymentConfig: 'rest')
}
```

Next, this buildConfig file can be used and launched from the OpenShift Web Console or using this openshift command

`oc start-build rest-build`

# Health

In order to monitor and manage the HTTP Service, this project uses [Spring Actuator°(https://github.com/spring-projects/spring-boot/tree/master/spring-boot-actuator).
To discover what is the status of the REST endpoint, you will issue this request 

```
curl $(minishift service rest --url=true)/health
```

Using the command defined hereafter, you can watch all the resources deployed and query them individually like `/metrics, /env, /dump, /configprops, /beans or /health`

```
curl $(minishift service rest --url=true)/mappings
```

It is also possible to use directly the Jolokia HTTP bridge to quety the JMX Mbeans. Here is an example of such request using the IP address of the Spring Boot service 
deployed on OpenShift to collect the metrics of the application

```
http 'http://192.168.64.56:31065/jolokia/exec/org.springframework.boot:type=Endpoint,name=metricsEndpoint/getData()'
```
