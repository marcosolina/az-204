#!/bin/bash
#Azure CLI template deployment

RESOURCE_GROUP=AZ204-Marco-apim-rg
RESOURCE_GROUP_LOCATION="UK South"
DEPLOYMENT_NAME=AZ204-Marco-Dep
ARM_TEMPLATE=arm-apim.json
OVERRIDE_PROPS=arm-apim-param.json

# Props to override
APIM_NAME=az204-marco-apim
ORG_NAME="Marco az204"
ADMIN_EMAIL="marcosolina@gmail.com"
APIM_TIER=Developer

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
	sed -i 's/APIM_NAME/'"$APIM_NAME"'/' $NEW_OVERRIDE_PROPS
	sed -i 's/ORG_NAME/'"$ORG_NAME"'/' $NEW_OVERRIDE_PROPS
	sed -i 's/ADMIN_EMAIL/'"$ADMIN_EMAIL"'/' $NEW_OVERRIDE_PROPS
	sed -i 's/APIM_TIER/'"$APIM_TIER"'/' $NEW_OVERRIDE_PROPS
	
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
	az group delete --name $RESOURCE_GROUP --yes
fi

echo ""
echo "End of the script"
echo ""