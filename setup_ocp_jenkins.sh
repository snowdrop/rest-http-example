#!/usr/bin/env bash

echo "Setup Openshift"
minishift delete
minishift start --vm-driver=xhyve --memory=6048 --deploy-registry=true --deploy-router=true --openshift-version=v1.3.1
oc login $(minishift ip):8443 -u=admin -p=admin

echo "Create a new project for ci/cd"
oc new-project ci-cd

echo "Add the template containing Openshift Jenkins"
oc create -f https://raw.githubusercontent.com/openshift/origin/master/examples/jenkins/jenkins-ephemeral-template.json -n openshift

echo "Deploy Jenkins (without persistence)"
oc new-app jenkins-ephemeral
