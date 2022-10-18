#!/usr/bin/env bash
# Run Tests
eval "./mvnw -s .github/mvn-settings.xml clean verify -Popenshift,openshift-it $@"
