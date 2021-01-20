#!/bin/bash

export GROUP_NAME=AZ204-Marco-rg

az group delete --name $GROUP_NAME

docker system prune --all