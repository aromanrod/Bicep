$resourceGroupName = "BicepTutoriales"
$templateFile = ./loops.bicep

New-AzResourceGroup -Name $resourceGroupName -Location eastus
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile ./loops.bicep
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile ./conditional.bicep