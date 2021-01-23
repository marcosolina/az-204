#!/bin/bash

# Some variable definition useful
# for the script
RESOURCE_GROUP=AZ204-Marco-rg
ACR_NAME=marcoacraz204
IMAGE_NAME=marco/bowling
AZURE_ACR_REPO=marcorepo/marcobowling
SERVICE_PRINCIPAL_NAME=az204marco_sp
IMAGE_TAG=$ACR_NAME.azurecr.io/$AZURE_ACR_REPO:latest
APP_NAME=marcobowling
APP_DNS_NAME=marcodns



# Get the registry ID. You will need this ID
# for creating the authorization to the service principal
ACR_ID=$(az acr show --name $ACR_NAME --query id --output tsv)

# Get the ACR login server
ACR_SERVER=$(az acr show --name $ACR_NAME --query loginServer --output tsv)

# Get the service principal password. We will grant
# pull only privileges to the service principal.
# The "http://" is required by azure, do not remove it...
# https://docs.microsoft.com/en-us/azure/container-registry/container-registry-roles
echo "Generating Service Principal password"
SP_PASS=$(az ad sp create-for-rbac --name http://$SERVICE_PRINCIPAL_NAME --scopes $ACR_ID --role reader --query password --output tsv)

# Get the App ID associated to the service principal
SP_ID=$(az ad sp show --id http://$SERVICE_PRINCIPAL_NAME --query appId --output tsv)
echo "Service principal ID: $SP_ID"
echo "Service principal password: $SP_PASS"

# Create the container in the Container Instance service
az container create --resource-group $RESOURCE_GROUP --name \
$APP_NAME --image \
$IMAGE_TAG --cpu 1 --memory 1 --registry-login-server \
$ACR_SERVER --registry-username \
$SP_ID --registry-password $SP_PASS --dns-name-label \
$APP_DNS_NAME --ports 80

echo "Open: http://marcodns.uksouth.azurecontainer.io/Bowling/"