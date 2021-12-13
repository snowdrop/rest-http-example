#!/usr/bin/env bash
SOURCE_REPOSITORY_URL=${1:-https://github.com/snowdrop/rest-http-example}
SOURCE_REPOSITORY_REF=${2:-sb-2.4.x}

source scripts/waitFor.sh

oc create -f .openshiftio/application.yaml
oc new-app --template=rest-http -p SOURCE_REPOSITORY_URL=$SOURCE_REPOSITORY_URL -p SOURCE_REPOSITORY_REF=$SOURCE_REPOSITORY_REF
if [[ $(waitFor "rest-http" "app") -eq 1 ]] ; then
  echo "Application failed to deploy. Aborting"
  exit 1
fi

# Run OpenShift Tests
./mvnw -s .github/mvn-settings.xml clean verify -Popenshift,openshift-it -Dunmanaged-test=true
