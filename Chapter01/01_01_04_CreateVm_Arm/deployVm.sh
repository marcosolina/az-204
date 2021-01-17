#!/bin/bash
#Azure CLI template deployment

export GROUP_NAME=AZ204-Marco-rg
export DEPLOYMENT_NAME=AZ204-Marco-Dep
export ARM_TEMPLATE=arm-deploy-vm.json
export OVERRIDE_PROPS=overrideParameters.json

az group create --name $GROUP_NAME --location "UK South"
az group deployment create \
--name $DEPLOYMENT_NAME \
--resource-group $GROUP_NAME \
--template-file $ARM_TEMPLATE \
--parameters @$OVERRIDE_PROPS