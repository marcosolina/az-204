#!/bin/bash
#Azure CLI template deployment

RESOURCE_GROUP=AZ204-Marco-vm-rg
RESOURCE_GROUP_LOCATION="UK South"
DEPLOYMENT_NAME=AZ204-Marco-Dep
ARM_TEMPLATE=arm-deploy-vm.json
OVERRIDE_PROPS=overrideParameters.json

# Props to override
VNET_NAME=az204MarcoVNET
NIC_NAME=az204MarcoNIC
VM_NAME=az204MarcoVM
SUBNET_NAME=az204MarcoSubnet
ODISK_NAME=_OSDisk1_Marco
ADMIN_USER=marcoadminuser
ADMIN_PASSWORD='marcoPa$$w0rd'
PUBLIC_IP_NAME=MarcoIpPublic

# This Resource Group is automatically created...
GROUP_NETWORK_WATCHERNAME=NetworkWatcherRG

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
	sed -i 's/VNET_NAME/'"$VNET_NAME"'/' $NEW_OVERRIDE_PROPS
	sed -i 's/NIC_NAME/'"$NIC_NAME"'/' $NEW_OVERRIDE_PROPS
	sed -i 's/VM_NAME/'"$VM_NAME"'/' $NEW_OVERRIDE_PROPS
	sed -i 's/SUBNET_NAME/'"$SUBNET_NAME"'/' $NEW_OVERRIDE_PROPS
	sed -i 's/ODISK_NAME/'"$ODISK_NAME"'/' $NEW_OVERRIDE_PROPS
	sed -i 's/ADMIN_USER/'"$ADMIN_USER"'/' $NEW_OVERRIDE_PROPS
	sed -i 's/ADMIN_PASSWORD/'"$ADMIN_PASSWORD"'/' $NEW_OVERRIDE_PROPS
	sed -i 's/REGION_AZ_VAL/'"$REGION_AZ_VAL"'/' $NEW_OVERRIDE_PROPS
	sed -i 's/PUBLIC_IP_NAME/'"$PUBLIC_IP_NAME"'/' $NEW_OVERRIDE_PROPS
	
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
	az group delete --name $GROUP_NETWORK_WATCHERNAME --yes
fi

echo ""
echo "End of the script"
echo ""