#!/bin/bash
#Azure CLI template deployment

export GROUP_NAME=AZ204-Marco-rg
export DEPLOYMENT_NAME=AZ204-Marco-Dep
export ARM_TEMPLATE=arm-create-az-container-registry.json
export OVERRIDE_PROPS=overrideParameters.json
export ACR_NAME=marcoacraz204
export IMAGE_NAME=marco/bowling
export DOCKER_FILE_FOLDER=DockerBowling
export AZURE_ACR_REPO=marcorepo/marcobowling


az group create --name $GROUP_NAME --location "UK South"
az deployment group create \
--name $DEPLOYMENT_NAME \
--resource-group $GROUP_NAME \
--template-file $ARM_TEMPLATE \
--parameters @$OVERRIDE_PROPS
# Note the use of the @ symbol in front of the parameters file. This @ symbol is required by the az group
# deployment create command.


# Creating my image, Version one and Version latest
docker build -t $IMAGE_NAME:1 $DOCKER_FILE_FOLDER
docker build -t $IMAGE_NAME $DOCKER_FILE_FOLDER

# Adding the "azure" tag to my image
docker tag $IMAGE_NAME $ACR_NAME.azurecr.io/$AZURE_ACR_REPO

# Loggin in into the Azure ACR
az acr login --name $ACR_NAME

# Pushing my image to Azure ACR
docker push $ACR_NAME.azurecr.io/$AZURE_ACR_REPO

./publishImage.sh