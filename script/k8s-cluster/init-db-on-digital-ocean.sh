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

doctl db get-ca $DBID -o json | jq -r .certificate | base64 -d > db-do.cert

doctl db list -o json | jq ".[0].connection" > connection-info.json

DB_HOST=`cat connection-info.json | jq ".[0].connection.host"`
DB_DATABASE=`cat connection-info.json | jq ".[0].connection.database"`
DB_USER=`cat connection-info.json | jq ".[0].connection.user"`
DB_PASSWD=`cat connection-info.json | jq ".[0].connection.password"`

cat script/db/my_burger_db_creation.sql | docker run -it --rm postgres -- psql -U $DB_USER -W -h $DB_HOST

