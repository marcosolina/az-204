#!/bin/bash
RESOURCE_GROUP=AZ204-Marco-Blob-Storages
RESOURCE_GROUP_LOCATION="UK South"
AZURE_STORAGE_ACCOUNT_NAME_1=az204chap2storage1
AZURE_STORAGE_ACCOUNT_NAME_2=az204chap2storage2
BLOB_CONTAINER_1=blbcontainer1
BLOB_CONTAINER_2=blbcontainer2

../../Misc/Scripts/selectSubscription.sh

while ! [[ "$EXEC_OPTION" =~ ^(0|1)$ ]]
do
  echo ""
  echo "0) Create Blob Storages"
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

	echo "Creating Resource Group"
	az group create --name $RESOURCE_GROUP --location "$RESOURCE_GROUP_LOCATION"

	######################################
	# I need to retrieve the Azure val
	# for the resource group "UK South" -> "uksouth"
	# and update the parameters that
	# I want to use when creating the
	# resource using the ARM template
	######################################
	REGION_AZ_VAL=$(az group show --name $RESOURCE_GROUP --query location --output tsv)

	echo "Creating Two Azure Storage"
	# Create an Azure storage account in the resource group.
	az storage account create --name $AZURE_STORAGE_ACCOUNT_NAME_1 --location $REGION_AZ_VAL --resource-group $RESOURCE_GROUP --sku Standard_LRS
	az storage account create --name $AZURE_STORAGE_ACCOUNT_NAME_2 --location $REGION_AZ_VAL --resource-group $RESOURCE_GROUP --sku Standard_LRS

	AZURE_STORAGE_KEY_1=$(az storage account keys list -g $RESOURCE_GROUP -n $AZURE_STORAGE_ACCOUNT_NAME_1 --query "[0].value" -o tsv)
	AZURE_STORAGE_KEY_2=$(az storage account keys list -g $RESOURCE_GROUP -n $AZURE_STORAGE_ACCOUNT_NAME_2 --query "[0].value" -o tsv)

	echo "Creating two blob containers"
	az storage container create --name $BLOB_CONTAINER_1 --public-access container --account-name $AZURE_STORAGE_ACCOUNT_NAME_1 --account-key $AZURE_STORAGE_KEY_1
	az storage container create --name $BLOB_CONTAINER_2 --public-access container --account-name $AZURE_STORAGE_ACCOUNT_NAME_2 --account-key $AZURE_STORAGE_KEY_2
fi

if [ $EXEC_OPTION = 1 ]
then
	az group delete --name $RESOURCE_GROUP --yes
	echo "Resource deleted"
fi

echo ""
echo "End of the script"
echo ""


