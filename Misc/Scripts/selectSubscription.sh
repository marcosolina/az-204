#!/bin/bash

echo "Retrieving the list of available subscriptions, please wait..."
echo ""
az account list --output table

echo ""
read -p "Type the subscription that you want to use: " SUBSCRIPTION_ID

echo ""
echo "You have selected: $SUBSCRIPTION_ID"

az account set --subscription "$SUBSCRIPTION_ID"

echo ""