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

