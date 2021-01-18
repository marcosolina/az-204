#!/bin/bash
#Azure CLI template deployment

export GROUP_NAME=AZ204-Marco-rg
export DEPLOYMENT_NAME=AZ204-Marco-Dep
export ARM_TEMPLATE=arm-create-az-container-registry.json

az group create --name $GROUP_NAME --location "UK South"
az deployment group create \
--name $DEPLOYMENT_NAME \
--resource-group $GROUP_NAME \
--template-file $ARM_TEMPLATE