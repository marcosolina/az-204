#!/bin/bash

GROUP_NAME=AZ204-Marco-rg
SERVICE_PRINCIPAL_NAME=az204marco_sp


# The "http://" is required by azure, do not remove it...
SP_ID=$(az ad sp show --id http://$SERVICE_PRINCIPAL_NAME --query appId --output tsv)
echo "Deleting service principal: $SP_ID"
az ad sp delete --id "$SP_ID"

echo "Deleting resource group"
az group delete --name $GROUP_NAME --yes

docker system prune --all --force