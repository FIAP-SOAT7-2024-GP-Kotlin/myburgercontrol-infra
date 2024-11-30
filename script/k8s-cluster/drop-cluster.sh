#!/bin/bash

echo "Deleting Kubernetes"
KUBERNETES_IDS=$(doctl kubernetes cluster list --format ID --no-header)
for KUBERNETES_IDS in $KUBERNETES_IDS; do
  echo "Deleting database with ID: $KUBERNETES_IDS"
  doctl kubernetes cluster delete $KUBERNETES_IDS --force
done

echo "Deleting Databases"
DB_IDS=$(doctl db list --format ID --no-header)
for DB_ID in $DB_IDS; do
  echo "Deleting database with ID: $DB_ID"
  doctl db delete $DB_ID --force
done

echo "Deleting Dropletes"
DROPLET_IDS=$(doctl compute droplet list --format ID --no-header)
for DROPLET_ID in $DROPLET_IDS; do
  echo "Deleting database with ID: $DROPLET_ID"
  doctl compute droplet delete $DROPLET_ID --force
done

echo "Deleting Load Balancers"
LB_IDS=$(doctl compute load-balancer list --format ID --no-header)
for LB_IDS in $LB_IDS; do
  echo "Deleting database with ID: $LB_IDS"
  doctl compute droplet delete $LB_IDS --force
done