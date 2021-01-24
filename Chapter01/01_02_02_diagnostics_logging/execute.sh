#!/bin/bash
#Azure CLI template deployment

while ! [[ "$EXEC_OPTION" =~ ^(0|1)$ ]] 
do
  echo ""
  echo "0) Download logs"
  echo "1) Stream logs"
  echo ""
  read -p "Choose one option: " EXEC_OPTION
  echo ""
done
 
echo "You choose $EXEC_OPTION"
echo ""
read -p "Type the resource group name: " RESOURCE_GROUP
read -p "Type the Web App name: " WEB_APP_NAME

if [ $EXEC_OPTION = 0 ]
then  
	
	read -p "Where do you want to store the file (path + file name): " LOG_FILE_PATH

	az webapp log download --resource-group "$RESOURCE_GROUP" --name "$WEB_APP_NAME" --log-file $LOG_FILE_PATH
fi

if [ $EXEC_OPTION = 1 ]
then  
	az webapp log tail --resource-group "$RESOURCE_GROUP" --name "$WEB_APP_NAME"
fi

echo ""
echo "End of the script"
echo ""