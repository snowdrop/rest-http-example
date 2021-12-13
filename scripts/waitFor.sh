#!/usr/bin/env bash

waitFor() {
  NAME=$1
  POD_LABEL=$2
  READY_TIMEOUT=600s
  LOOP=2s
  RETRIES=300

  idx=0
  # Wait for pod to be created
  while ! [[ $(oc get pods -l $POD_LABEL=$NAME --ignore-not-found | wc -l) -ge 1 ]] ;
  do
    if [[ $idx -eq $RETRIES ]] ; then
      echo "$NAME pods failed to be created. Aborting..."
      return 1
    fi
    sleep $LOOP
    echo "Waiting for pod to be created..."
    idx=$((idx+1))
  done
  # Wait for pod to be ready
  if [[ $(oc wait --for=condition=ready --timeout=$READY_TIMEOUT pod -l $POD_LABEL=$NAME | grep "condition met" | wc -l) -eq 0 ]] ; then
    echo "$NAME pods failed to be ready. Aborting..."
    return 1
  fi

  return 0
}
