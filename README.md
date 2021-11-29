[![CircleCI](https://circleci.com/gh/snowdrop/rest-http-example/tree/master.svg?style=shield)](https://circleci.com/gh/snowdrop/rest-http-example/tree/master)

https://appdev.openshift.io/docs/spring-boot-runtime.html#mission-http-api-spring-boot

## Deploying application on OpenShift using Dekorate:

```
mvn clean verify -Popenshift -Ddekorate.push=true
```

## Running Tests on OpenShift using Dekorate:

```
sh run_tests_with_dekorate.sh
```

## Running Tests on OpenShift using S2i from Source:

```
sh run_tests_with_s2i.sh
```

## Running Tests on Kubernetes with External Registry:

```
mvn clean verify clean verify -Pkubernetes,kubernetes-it -Ddekorate.docker.registry=<url to your registry, example: quay.io> -Ddekorate.push=true
```
