#!/usr/bin/env bash
CONTAINER_REGISTRY=${1:-localhost:5000}
K8S_NAMESPACE=${2:-helm}

source scripts/waitFor.sh
oc project $K8S_NAMESPACE

# Build
./mvnw -s .github/mvn-settings.xml clean package

# Create docker image and tag it in registry
IMAGE=rest-http:latest
docker build . -t $IMAGE
docker tag $IMAGE $CONTAINER_REGISTRY/$IMAGE
docker push $CONTAINER_REGISTRY/$IMAGE

helm install rest-http ./helm --set app.docker.image=$CONTAINER_REGISTRY/$IMAGE -n $K8S_NAMESPACE
if [[ $(waitFor "rest-http" "app") -eq 1 ]] ; then
  echo "Application failed to deploy. Aborting"
  exit 1
fi

# Run Tests
./mvnw -s .github/mvn-settings.xml clean verify -Pkubernetes-it -Dunmanaged-test=true -Dkubernetes.namespace=$K8S_NAMESPACE
