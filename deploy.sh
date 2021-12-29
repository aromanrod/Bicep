resourceGroupName = "Biceptutorial"
templateFile= loops.bicep

az group create --name $resourceGroupName --location eastus

az deployment group create --resource-group $resourceGroupName --template-file $templateFile