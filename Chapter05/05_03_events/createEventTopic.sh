#!/bin/bash
#Azure CLI template deployment

RESOURCE_GROUP=az204-marco-event-grid-topic-rg
RESOURCE_GROUP_LOCATION="UK South"
AZURE_STORAGE_ACCOUNT_NAME=marcoeventstorage
DEPLOYMENT_NAME=AZ204-Marco-Dep
ARM_TEMPLATE=arm-event-grid-topic.json
OVERRIDE_PROPS=arm-event-grid-topic-param.json

# Props to override
TOPIC_NAME=az204-marco-event-grid-topic

../../Misc/Scripts/selectSubscription.sh

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
	APP_LOCATION=$(az group show --name $RESOURCE_GROUP --query location --output tsv)

	NEW_OVERRIDE_PROPS=tempParam.json
	cp $OVERRIDE_PROPS $NEW_OVERRIDE_PROPS
	sed -i 's/TOPIC_NAME/'"$TOPIC_NAME"'/' $NEW_OVERRIDE_PROPS
	sed -i 's/LOCATION/'"$APP_LOCATION"'/' $NEW_OVERRIDE_PROPS
	
	######################################
	# Createing the resource in the
	# resource group
	######################################
	az deployment group create \
	--name $DEPLOYMENT_NAME \
	--resource-group $RESOURCE_GROUP \
	--template-file $ARM_TEMPLATE \
	--parameters @$NEW_OVERRIDE_PROPS
	# Note the use of the @ symbol in front of the parameters file. This @ symbol is required by the az group
	# deployment create command.
	
	rm $NEW_OVERRIDE_PROPS
	
	while ! [[ "$STORAGE_OPTION" =~ ^(0|1)$ ]] 
	do
	echo ""
	echo "0) Create Storage Account"
	echo "1) No"
	echo ""
	read -p "Do you want to create a storage account?: " STORAGE_OPTION
	echo ""
	done
	
	echo "You choose $STORAGE_OPTION"

	if [ $STORAGE_OPTION = 0 ]
	then  
		az storage account create --name $AZURE_STORAGE_ACCOUNT_NAME --location $APP_LOCATION --resource-group $RESOURCE_GROUP --sku Standard_LRS
	fi
fi


if [ $EXEC_OPTION = 1 ]
then
	az group delete --name $RESOURCE_GROUP --yes
fi

echo ""
echo "End of the script"
echo ""