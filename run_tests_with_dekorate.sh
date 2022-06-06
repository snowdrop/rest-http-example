#!/usr/bin/env bash

SB_VERSION_SWITCH=""

while getopts v: option
do
    case "${option}"
        in
        v)SB_VERSION_SWITCH="-Dspring-boot.version=${OPTARG}";;
    esac
done

echo "SB_VERSION_SWITCH: ${SB_VERSION_SWITCH}"

# Run OpenShift Tests
eval "./mvnw -s .github/mvn-settings.xml clean verify -Popenshift,openshift-it ${SB_VERSION_SWITCH}"
