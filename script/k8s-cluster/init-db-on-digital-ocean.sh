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

DB_HOST=`cat ./tmp/connection-info.json | jq ".host"`
DB_DATABASE=`cat ./tmp/connection-info.json | jq ".database"`
DB_USER=`cat ./tmp/connection-info.json | jq ".user"`
DB_PASSWD=`cat ./tmp/connection-info.json | jq ".password"`

echo "DB_HOST=$DB_HOST"
echo "DB_DATABASE=$DB_DATABASE"
echo "DB_USER=$DB_USER"
echo "DB_PASSWD=$DB_PASSWD"

# cat script/db/my_burger_db_creation.sql | docker run -it --rm postgres -- psql -U $DB_USER -W -h $DB_HOST

