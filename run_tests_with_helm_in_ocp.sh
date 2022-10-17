#!/usr/bin/env bash
SOURCE_REPOSITORY_URL=${1:-https://github.com/snowdrop/rest-http-example}
SOURCE_REPOSITORY_REF=${2:-sb-2.7.x}

source scripts/waitFor.sh

helm install rest-http ./helm --set app.route.expose=true --set app.s2i.source.repo=$SOURCE_REPOSITORY_URL --set app.s2i.source.ref=$SOURCE_REPOSITORY_REF --set app.s2i.builderImage.repo=registry.access.redhat.com/ubi8/openjdk-11 --set app.s2i.builderImage.tag=1.14
if [[ $(waitFor "rest-http" "app") -eq 1 ]] ; then
  echo "Application failed to deploy. Aborting"
  exit 1
fi

# Run Tests
./mvnw -s .github/mvn-settings.xml clean verify -Popenshift,openshift-it -Dunmanaged-test=true
