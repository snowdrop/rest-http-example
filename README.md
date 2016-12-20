# Introduction

This project exposes a simple REST endpoint where the service `greeting` is available at this address `http://hostname:port/greeting` and returns a json Greeting message

```json
{
    "content": "Hello, World!",
    "id": 1
}

```

The id of the message is incremented for each request. 
To customize the message, you can pass as parameter the name of the person that you want to send your greeting.

You can perform this task in three different ways:

1. Build and launch using Spring Boot.
1. Build and deploy using OpenShift.
1. Build, deploy, and authenticate using OpenShift Online.

# Build the Project

The project bundles the Apache Tomcat 8.0.36 artifacts with SpringBoot 1.4.1.RELEASE.

Execute the following maven command:

```
mvn clean install
```

# Launch and test

1. Run the following command to start the maven goal of Spring Boot:

    ```
    mvn spring-boot:run
    ```

1. If the application launched without error, use the following command to access the REST endpoint exposed using curl or httpie tool:

    ```
    http http://localhost:8080/greeting
    curl http://localhost:8080/greeting
    ```

1. To pass a parameter for the Greeting Service, use the following HTTP request:

    ```
    http http://localhost:8080/greeting name==Charles
    curl http://localhost:8080/greeting -d name=Bruno
    ```

# Build and Deploy Using OpenShift

1. Deploy the project on Openshift using the [minishift tool](https://github.com/minishift/minishift), which installs OpenShift on a virtual machine (Virtualbox, libvirt or Xhyve) like a Docker daemon.

    ```
    minishift delete
    minishift start --openshift-version=v1.3.1
    eval $(minishift docker-env)
    oc login --username=admin --password=admin
    ```

1. Configure the Fabric8 Maven plug-in.

    ```
    mvn clean fabric8:build -Popenshift
    ```

    The Fabric8 plug-in is a Java OpenShift/Kubernetes API that communicates with the platform to build the Docker image and to create a pod from the application image.

1. To use the official Red Hat S2I image, configure the Fabric8 Maven Plug-in to use the Java S2I image with the following  parameter: 

    ```
    -Dfabric8.generator.from=registry.access.redhat.com/jboss-fuse-6/fis-java-openshift
    ```

1. Deploy the application and create the pod.

    ```
    mvn fabric8:deploy -Popenshift
    ```

1. Test the service.

    ```
    http $(minishift service NAME_OF_THE_SERVICE --url=true)/greeting
    ```

1. To test the project against OpenShift using Arquillian, run the following command:

    ```
    mvn clean verify -Popenshift
    ```

# OpenShift Online

1. Go to [OpenShift Online](https://console.dev-preview-int.openshift.com/console/command-line) to get the token used by the oc client for authentication and project access. 

1. On the oc client, execute the following command to replace MYTOKEN with the one from the Web Console:

    ```
    oc login https://api.dev-preview-int.openshift.com --token=MYTOKEN
    ```
1. Use the Fabric8 Maven Plugin to launch the S2I process on the OpenShift Online machine.

    ```
    mvn clean fabric8:deploy -Popenshift
    ```

1. Launch the pod.

    ```
    mvn clean fabric8:start -Popenshift -DskipTests
    ```

1. Create the route to access the service.

    ```
    oc expose service/NAME_OF_THE_SERVICE --port=8080 
    ```
    
1. Get the route url.

    ```
    oc get route/get route/springboot-rest
    NAME              HOST/PORT                                          PATH      SERVICE                TERMINATION   LABELS
    springboot-rest   springboot-rest-sb.e8ca.engint.openshiftapps.com             springboot-rest:8080
    ```

1. Use the Host or Port address to access the REST endpoint.
    ```
    http http://<HOST_PORT_ADDRESS>/greeting
    http http://<HOST_PORT_ADDRESS>/greeting name==Bruno

    or 

    curl http://<HOST_PORT_ADDRESS>/greeting
    curl http://<HOST_PORT_ADDRESS>/greeting name==Bruno
    ```
