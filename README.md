# Introduction

This Mission showcases a basic mapping of a business operation to a remote endpoint. By taking this approach, clients leverage the HTTP protocol as a transport mechanism to call upon services. Application engineers define their APIs using a broad interpretation of REST fundamentals, encouraging freedom in design and quick prototyping.

As an application or service matures, this approach may not scale as desired to properly support clean API design or use cases involving database interactions. Any operations involving shared, mutable state will have to be integrated with an appropriate backing datastore; all requests here will be scoped only to the container servicing the request, and there is no guarantee that subsequent requests will be served by the same container.

This is recommended as an introduction to the mechanics of opening a service to be called upon by remote processes.

# Prerequisites

To get started with this booster you'll need the following prerequisites:

Name | Description | Version
--- | --- | ---
[java][1] | Java JDK | 8
[maven][2] | Apache Maven | 3.3.9 
[oc][3] | OpenShift Client | v3.3.x
[git][4] | Git version management | 2.x 

[1]: http://www.oracle.com/technetwork/java/javase/downloads/
[2]: https://maven.apache.org/download.cgi?Preferred=ftp://mirror.reverse.net/pub/apache/
[3]: https://docs.openshift.com/enterprise/3.2/cli_reference/get_started_cli.html
[4]: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

In order to build and deploy this project, you must have an account on an OpenShift Online (OSO): https://console.dev-preview-int.openshift.com/ instance.

# Run Locally

1. Execute the following maven command to start the application:

    ```
    mvn clean spring-boot:run
    ```

1. If the application launched without errors, use one of the following commands to access the HTTP endpoint using curl or httpie:

    ```
    http http://localhost:8080/api/greeting
    curl http://localhost:8080/api/greeting
    ```

1. To pass a parameter for the Greeting Service, use one of the following commands:

    ```
    http http://localhost:8080/api/greeting name==Charles
    curl http://localhost:8080/api/greeting -d name=Bruno
    ```

# Run on OpenShift Online

1. Go to [OpenShift Online](https://console.dev-preview-int.openshift.com/console/command-line) to get the token used by the oc client for authentication and project access. 

1. On the oc client execute the following command to replace MYTOKEN with the one from the Web Console:

    ```
    oc login https://api.dev-preview-int.openshift.com --token=MYTOKEN
    ```

1. Use Fabric8 Maven Plugin to launch an S2I process on the OpenShift Online machine & start the pod:

    ```
    mvn clean fabric8:deploy -Popenshift
    ```
    
1. Get a route url to access the service:

    ```
    oc get route/spring-boot-http
    ``` 

    NAME | HOST/PORT | PATH | SERVICES | PORT | TERMINATION
    ---- | --------- | ---- | -------- | ---- | -----------
    spring-boot-http | <HOST_PORT_ADDRESS> | | spring-boot-http | 8080 | 

1. Use host address to access the service HTTP endpoint:
    ```
    http http://<HOST_PORT_ADDRESS>/api/greeting
    http http://<HOST_PORT_ADDRESS>/api/greeting name==Bruno

    or 

    curl http://<HOST_PORT_ADDRESS>/api/greeting
    curl http://<HOST_PORT_ADDRESS>/api/greeting -d name=Bruno
    ```
