#!/bin/bash
PROJECT_NAME=my-burger
K8S_CLUSTER_NAME=$PROJECT_NAME-k8s

doctl kubernetes cluster get $K8S_CLUSTER_NAME

echo "Deleting $K8S_CLUSTER_NAME Cluster and all resources"
doctl kubernetes cluster delete --dangerous $K8S_CLUSTER_NAME

# Deleting the database
echo "Deleting Databases"
DB_IDS=$(doctl db list -o json | jq -r '.[].id')

for DB_ID in $DB_IDS; do
  echo "Deleting database with ID: $DB_ID"
  doctl db delete $DB_ID --force
done

echo "Deleting api-gtw"
DROPLET_IDS=$(doctl compute droplet list --format ID --no-header)
for DROPLET_ID in $DROPLET_IDS; do
  echo "Deleting database with ID: $DROPLET_ID"
  doctl compute droplet delete $DROPLET_ID --force
done