#!/bin/bash
PROJECT_ID=1f3e6919-579f-400b-9dab-a6dafaaaafa7
PROJECT_NAME=soat7myburger

doctl kubernetes cluster get $PROJECT_NAME-k8s

echo "Deleting $PROJECT_NAME-k8s Cluster and all resources"
doctl kubernetes cluster delete --dangerous $PROJECT_NAME-k8s

# Deleting the database
DBID=`doctl db list -o json | jq ".[0].id"`
doctl db delete $DBID --force