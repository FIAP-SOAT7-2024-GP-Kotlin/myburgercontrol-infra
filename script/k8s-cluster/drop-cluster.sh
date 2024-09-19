#!/bin/bash
PROJECT_NAME=soat7myburger
K8S_CLUSTER_NAME=$PROJECT_NAME-k8s

doctl kubernetes cluster get $K8S_CLUSTER_NAME

echo "Deleting $K8S_CLUSTER_NAME Cluster and all resources"
doctl kubernetes cluster delete --dangerous $K8S_CLUSTER_NAME

# Deleting the database
DBID=`doctl db list -o json | jq ".[0].id"`
doctl db delete $DBID --force
