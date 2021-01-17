#!/bin/bash

export GROUP_NAME=AZ204-Marco-rg
export GROUP_NETWORK_WATCHERNAME=NetworkWatcherRG

az group delete --name $GROUP_NAME
az group delete --name $GROUP_NETWORK_WATCHERNAME