#!/bin/bash
#Azure CLI template deployment

######################################
# Setting some properties to make my
# life easier :)
######################################
# Props. For group and resources
RESOURCE_GROUP=AZ204-Marco-docker-rg
RESOURCE_GROUP_LOCATION="UK South"
DEPLOYMENT_NAME=AZ204-Marco-Dep
ARM_TEMPLATE=arm-create-az-container-registry.json
OVERRIDE_PROPS=overrideParameters.json

# Props. for Local Docker
DOCKER_IMAGE_NAME=marco/bowling
DOCKER_FILE_FOLDER=DockerBowling

# Props for Azure Container Registrer
ACR_NAME=az204marcoacr
ACR_REPO_NAME=marcorepo/marcobowling
ACR_SERVICE_PRINCIPAL_NAME=az204marco-service-principal
ACR_IMAGE_TAG=$ACR_NAME.azurecr.io/$ACR_REPO_NAME:latest

# Props for Azure Container Istance
ACI_APP_NAME=marcobowling
ACI_APP_DNS_NAME=marcodns

# Misc. Props.
APP_CONTEXT_PATH=/Bowling
APP_PORT=8080

while ! [[ "$EXEC_OPTION" =~ ^(0|1)$ ]] 
do
  echo ""
  echo "0) Deploy"
  echo "1) Delete"
  echo ""
  read -p "Choose one option: " EXEC_OPTION
  echo ""
done
 
echo "You choose $EXEC_OPTION"

if [ $EXEC_OPTION = 0 ]
then  
          
	######################################
	# Createing the resource group
	######################################
	az group create --name $RESOURCE_GROUP --location "$RESOURCE_GROUP_LOCATION"
	
	
	######################################
	# I need to retrieve the Azure val
	# for the resource group "UK South" -> "uksouth"
	# and update the parameters that
	# I want to use when creating the 
	# resource using the ARM template
	######################################
	GROUP_LOCATION_VAL=$(az group show --name $RESOURCE_GROUP --query location --output tsv)

	NEW_OVERRIDE_PROPS=tempParam.json
	cp $OVERRIDE_PROPS $NEW_OVERRIDE_PROPS
	sed -i 's/AZURE_CONTAINER_REGISTER_NAME/'"$ACR_NAME"'/' $NEW_OVERRIDE_PROPS
	sed -i 's/AZURE_REGION/'"$GROUP_LOCATION_VAL"'/' $NEW_OVERRIDE_PROPS	
	
	######################################
	# Createing the resource in the
	# resource group
	######################################
	az deployment group create \
	--name $DEPLOYMENT_NAME \
	--resource-group $RESOURCE_GROUP \
	--template-file $ARM_TEMPLATE \
	--parameters @$NEW_OVERRIDE_PROPS
	# Note the use of the @ symbol in front of the parameters file.
	# This @ symbol is required by the az group deployment create command.
	
	rm $NEW_OVERRIDE_PROPS
	
	
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
	$ACI_APP_DNS_NAME --ports $APP_PORT
	
	echo "Open: http://$ACI_APP_DNS_NAME.$GROUP_LOCATION_VAL.azurecontainer.io:$APP_PORT$APP_CONTEXT_PATH"

fi

if [ $EXEC_OPTION = 1 ]
then
	# The "http://" is required by azure, do not remove it...
	SP_ID=$(az ad sp show --id http://$ACR_SERVICE_PRINCIPAL_NAME --query appId --output tsv)
	echo "Deleting service principal: $SP_ID"
	az ad sp delete --id "$SP_ID"
	
	echo "Deleting resource group"
	az group delete --name $RESOURCE_GROUP --yes
	
	docker system prune --all --force
fi

echo ""
echo "End of the script"
echo ""