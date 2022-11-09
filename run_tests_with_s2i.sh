#!/usr/bin/env bash
# Parameters allowed:
#   . --repository-url
#   . --branch-to-test
#   . --maven-settings
SOURCE_REPOSITORY_URL="https://github.com/snowdrop/rest-http-example"
SOURCE_REPOSITORY_REF="sb-2.7.x"
MAVEN_SETTINGS_REF=""

while [ $# -gt 0 ]; do
  if [[ $1 == *"--"* ]]; then
    param="${1/--/}"
    case $1 in
      --repository-url) SOURCE_REPOSITORY_URL="$2";;
      --branch-to-test) SOURCE_REPOSITORY_REF="$2";;
      --maven-settings) MAVEN_SETTINGS_REF="-s $2";;
    esac;
  fi
  shift
done

source scripts/waitFor.sh

oc create -f .openshiftio/application.yaml
oc new-app --template=rest-http -p SOURCE_REPOSITORY_URL=$SOURCE_REPOSITORY_URL -p SOURCE_REPOSITORY_REF=$SOURCE_REPOSITORY_REF
if [[ $(waitFor "rest-http" "app") -eq 1 ]] ; then
  echo "Application failed to deploy. Aborting"
  exit 1
fi

# Run Tests
eval "./mvnw ${MAVEN_SETTINGS_REF} clean verify -Popenshift,openshift-it -Dunmanaged-test=true"
