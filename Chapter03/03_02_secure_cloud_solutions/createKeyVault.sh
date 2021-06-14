#!/bin/bash
#Azure CLI template deployment

RESOURCE_GROUP=AZ204-Marco-keyvault-rg
RESOURCE_GROUP_LOCATION="UK South"
DEPLOYMENT_NAME=AZ204-Marco-Dep
ARM_TEMPLATE=arm-keyvault.json
OVERRIDE_PROPS=keyvault-params-simple.json

# Props to override
KEYVAULT_NAME=az204marcokv

../../Misc/Scripts/selectSubscription.sh

while ! [[ "$EXEC_OPTION" =~ ^(0|1)$ ]] 
do
  echo ""
  echo "0) Deploy Key Vault"
  echo "1) Delete Key Vault"
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
	sed -i 's/KEYVAULT_NAME/'"$KEYVAULT_NAME"'/' $NEW_OVERRIDE_PROPS
	sed -i 's/LOCATION/'"$REGION_AZ_VAL"'/' $NEW_OVERRIDE_PROPS

	while ! [[ "$WEB_APP_REG" =~ ^(0|1)$ ]] 
	do
	echo ""
	echo "0) Register Web APP"
	echo "1) Do NOT register Web APP"
	echo ""
	read -p "Choose one option: " WEB_APP_REG
	echo ""
	done

	if [ $WEB_APP_REG = 0 ]
	then
		OVERRIDE_PROPS=keyvault-params.json
		cp $OVERRIDE_PROPS $NEW_OVERRIDE_PROPS
		sed -i 's/KEYVAULT_NAME/'"$KEYVAULT_NAME"'/' $NEW_OVERRIDE_PROPS
		sed -i 's/LOCATION/'"$REGION_AZ_VAL"'/' $NEW_OVERRIDE_PROPS
		az webapp list --output table
		read -p "Type the Webapp name: " WEB_APP_NAME
		read -p "Type the WebApp resource group: " WEB_APP_RG

		WEBAPP_PRINCIPAL_ID=$(az webapp identity show --name $WEB_APP_NAME --resource-group $WEB_APP_RG --query principalId --output tsv)
		sed -i 's/WEBAPP_PRINCIPAL_ID/'"$WEBAPP_PRINCIPAL_ID"'/' $NEW_OVERRIDE_PROPS
	fi
	
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
    az keyvault purge --name $KEYVAULT_NAME
fi

echo ""
echo "End of the script"
echo ""