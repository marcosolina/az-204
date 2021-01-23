#!/bin/bash
#Azure CLI template deployment

######################################
# Setting some properties to make my
# life easier :)
######################################
# Props. For group and resources
RESOURCE_GROUP=AZ204-Marco-rg
RESOURCE_GROUP_LOCATION="UK South"
DEPLOYMENT_NAME=AZ204-Marco-Dep
ARM_TEMPLATE=arm-create-az-container-registry.json
OVERRIDE_PROPS=overrideParameters.json

# Props. for Local Docker
ACR_NAME=marcoacraz204
DOCKER_IMAGE_NAME=marco/bowling
DOCKER_FILE_FOLDER=DockerBowling

# Props for Azure Container Registrer
ACR_REPO_NAME=marcorepo/marcobowling
ACR_SERVICE_PRINCIPAL_NAME=az204marco_sp
ACR_IMAGE_TAG=$ACR_NAME.azurecr.io/$ACR_REPO_NAME:latest

# Props for Azure Container Istance
ACI_APP_NAME=marcobowling
ACI_APP_DNS_NAME=marcodns

# Misc. Props.
APP_CONTEXT_PATH=/Bowling


######################################
# Createing the resource group and
# deploying the ARM template
######################################
az group create --name $RESOURCE_GROUP --location "$RESOURCE_GROUP_LOCATION"
az deployment group create \
--name $DEPLOYMENT_NAME \
--resource-group $RESOURCE_GROUP \
--template-file $ARM_TEMPLATE \
--parameters @$OVERRIDE_PROPS
# Note the use of the @ symbol in front of the parameters file.
# This @ symbol is required by the az group deployment create command.


# Creating my local Docker image, Version one and Version latest
docker build -t $DOCKER_IMAGE_NAME:1 $DOCKER_FILE_FOLDER
docker build -t $DOCKER_IMAGE_NAME $DOCKER_FILE_FOLDER

# Adding the "azure" tag to my image
docker tag $DOCKER_IMAGE_NAME $ACR_NAME.azurecr.io/$ACR_REPO_NAME

# Loggin in into the Azure ACR
az acr login --name $ACR_NAME

# Pushing my image to Azure ACR
docker push $ACR_NAME.azurecr.io/$ACR_REPO_NAME

############################

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
SP_PASS=$(az ad sp create-for-rbac --name http://$ACR_SERVICE_PRINCIPAL_NAME --scopes $ACR_ID --role acrpull --query password --output tsv)

# Get the App ID associated to the service principal
SP_ID=$(az ad sp show --id http://$ACR_SERVICE_PRINCIPAL_NAME --query appId --output tsv)
echo "Service principal ID: $SP_ID"
echo "Service principal password: $SP_PASS"

# Create the container in the Container Instance service
az container create --resource-group $RESOURCE_GROUP --name \
$ACI_APP_NAME --image \
$ACR_IMAGE_TAG --cpu 1 --memory 1 --registry-login-server \
$ACR_SERVER --registry-username \
$SP_ID --registry-password $SP_PASS --dns-name-label \
$ACI_APP_DNS_NAME --ports 80

GROUP_LOCATION_VAL=$(az group show --name $RESOURCE_GROUP --query location --output tsv)

echo "Open: http://$ACI_APP_DNS_NAME.$GROUP_LOCATION_VAL.azurecontainer.io$APP_CONTEXT_PATH"