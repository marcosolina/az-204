#!/bin/bash
#Azure CLI template deployment

RESOURCE_GROUP=AZ204-Marco-Func-App-rg
RESOURCE_GROUP_LOCATION="UK South"
DEPLOYMENT_NAME=AZ204-Marco-Dep
STORAGE_ACCOUNT_NAME=az204marcofunc

ARM_TEMPLATE=arm-create-http-function-template.json
OVERRIDE_PROPS=arm-template.env.parameters.json

# Props to override
FUNC_APP_NAME=Az204MarcoFunc

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
	REGION_AZ_VAL=$(az group show --name $RESOURCE_GROUP --query location --output tsv)

	NEW_OVERRIDE_PROPS=tempParam.json
	cp $OVERRIDE_PROPS $NEW_OVERRIDE_PROPS
	sed -i 's/FUNC_APP_NAME/'"$FUNC_APP_NAME"'/' $NEW_OVERRIDE_PROPS
	sed -i 's/STORAGE_ACCOUNT_NAME/'"$STORAGE_ACCOUNT_NAME"'/' $NEW_OVERRIDE_PROPS
	
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