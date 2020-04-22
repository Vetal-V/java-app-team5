#!/bin/bash

location="East US"
randomIdentifier=random123

resource="prd-crashdb-rg-eastus-crashcourse"
server="prd-sqlserver-eastus-crashcourse"
database="prd-sqldb-eastus-crashcourse"

storage="crashdbsa"
container="container-$randomIdentifier"
bacpac="crashdb.bacpac"

# for admin of sql server
login="LOGINVALUE"
password="PASSWORDVALUE"

# Creating $container on $storage
key=$(az storage account keys list --account-name $storage --resource-group $resource -o json --query [0].value | tr -d '"')
az storage container create --name $container --account-key $key --account-name $storage #--public-access container

# Uploading sample database to $container
az storage blob upload --container-name $container --file $bacpac --name $bacpac --account-key $key --account-name $storage

# Creating $database
az sql db create --name $database --resource-group $resource --server $server --edition "Basic"

# Importing crashdb database from $container to $database
az sql db import --admin-password $password --admin-user $login --storage-key $key --storage-key-type StorageAccessKey --storage-uri https://$storage.blob.core.windows.net/$container/$bacpac --name $database --resource-group $resource --server $server
