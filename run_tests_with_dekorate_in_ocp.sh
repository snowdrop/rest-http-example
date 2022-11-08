#!/usr/bin/env bash
# Run Tests
eval "./mvnw clean verify -Popenshift,openshift-it $@"
