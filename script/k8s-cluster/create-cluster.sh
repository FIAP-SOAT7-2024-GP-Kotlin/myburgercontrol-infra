#!/bin/bash
PROJECT_NAME=soat7myburger

doctl projects list
PROJECT_ID=`doctl projects list -o json | jq -r ".[0].id"`

doctl vpcs list

VPC_ID=`doctl vpcs list -o json | jq '.[] | select(.region=="nyc3") | .id' -r`
K8S_CLUSTER_NAME=$PROJECT_NAME-k8s

# Create K8S Cluster - soat7myburger-k8s
echo "Creating K8s Cluster on $PROJECT_NAME-vpc"
doctl kubernetes cluster create $K8S_CLUSTER_NAME \
    --node-pool "name=$PROJECT_NAME-node-pool;size=s-2vcpu-4gb;count=1;auto-scale=true;min-nodes=1;max-nodes=3" \
    --region nyc3 --vpc-uuid $VPC_ID --wait

# List K8S Clusteres
# doctl kubernetes cluster list

doctl kubernetes cluster get $K8S_CLUSTER_NAME

DO_CLUSTER_ID=`doctl kubernetes cluster get $K8S_CLUSTER_NAME -o json | jq ".[0].id" -r`

# Project Myburger UUID = 1f3e6919-579f-400b-9dab-a6dafaaaafa7
echo "Cluster ID = $DO_CLUSTER_ID"

echo "Assign K8s Cluster (ID=$DO_CLUSTER_ID) with Myburger Project (ID=$PROJECT_ID)"
doctl projects resources assign $PROJECT_ID --resource="do:kubernetes:$DO_CLUSTER_ID"

doctl kubernetes cluster kubeconfig save $K8S_CLUSTER_NAME
