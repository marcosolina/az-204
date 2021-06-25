#!/bin/bash
#Azure CLI template deployment

DEPLOYMENT_NAME=AZ204-Marco-Dep
ARM_TEMPLATE=arm-custom-connector.json
OVERRIDE_PROPS=arm-custom-connector-param.json

# Props to override
CONNECTOR_NAME=az204-marco-custom-connector

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
	# Selecting the resource group
	######################################
	az group list --output table

	read -p "Select the resource group: " RESOURCE_GROUP
	
	######################################
	# I need to retrieve the Azure val
	# for the resource group "UK South" -> "uksouth"
	# and update the parameters that
	# I want to use when creating the 
	# resource using the ARM template
	######################################
	LOCATION=$(az group show --name $RESOURCE_GROUP --query location --output tsv)

	NEW_OVERRIDE_PROPS=tempParam.json
	cp $OVERRIDE_PROPS $NEW_OVERRIDE_PROPS
	sed -i 's/CONNECTOR_NAME/'"$CONNECTOR_NAME"'/' $NEW_OVERRIDE_PROPS
	sed -i 's/LOCATION/'"$LOCATION"'/' $NEW_OVERRIDE_PROPS
	
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
	
fi

if [ $EXEC_OPTION = 1 ]
then
	az group list --output table
	read -p "Select the resource group: " RESOURCE_GROUP
	az group delete --name $RESOURCE_GROUP --yes
fi

echo ""
echo "End of the script"
echo ""