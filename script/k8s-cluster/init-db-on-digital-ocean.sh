#!/bin/bash

doctl databases create \
    --engine pg \
    --version 16 \
    --size db-s-1vcpu-1gb \
    --region nyc3 \
    --tag myburger \
    --wait \
    -o json \
    myburger-db-server

DBID=`doctl db list -o json | jq ".[0].id"`

mkdir -p tmp

doctl db get-ca $DBID -o json | jq -r .certificate | base64 -d > tmp/db-do.cert

doctl db list -o json | jq ".[0].connection" > tmp/connection-info.json

DB_URI=`cat ./tmp/connection-info.json | jq ".uri" -r`

cat script/db/my_burger_db_creation.sql | docker run -i --rm fiapmyburguer/postgresql-client -- $DB_URI

