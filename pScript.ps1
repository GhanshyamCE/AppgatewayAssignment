
Import-Module Az 

Connect-AzAccount
Get-AzContext

Select-AzSubscription -SubscriptionName "4c12fb1b-cfd8-4a33-8df0-93243bc7e3fa"

Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force -Scope Process

#### Api-version
((Get-AzResourceProvider -ProviderNamespace Microsoft.Web).ResourceTypes | Where-Object ResourceTypeName -eq sites).ApiVersions
(Get-AzResourceProvider -ProviderNamespace Microsoft.Web).ResourceTypes | Format-Table
$Provider=Get-AzResourceProvider | Format-Table 
$Provider.ResourceTypes
#####
$resourceGroupName = "TestGateway-sql"
New-AzResourceGroup -Name $resourceGroupName  -Location "East Asia" -Force 

# Just validates the json file from github
Test-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
-TemplateUri './azuredeploy-main.json' `
-TemplateParameterUri './azuredeploy.paramaters.json'

Remove-AzResourceGroup $resourceGroupName -Force
New-AzResourceGroup -Name $resourceGroupName  -Location "East Asia" -Force 

#$resourceGroupDeployment = New-AzResourceGroupDeployment -Name $resourceGroupName'Deployment' -ResourceGroupName $resourceGroupName `
#-TemplateFile .\\arm-functionapp-sql-main.json -TemplateParameterFile .\armdeploy-functionappsql.paramaters.json -DeploymentDebugLogLevel All -Mode Complete -Force

# Deploy from Github repo
$resourceGroupDeployment = New-AzResourceGroupDeployment -Name $resourceGroupName'Deployment' -ResourceGroupName $resourceGroupName `
-TemplateUri './azuredeploy-main.json' `
-TemplateParameterUri './azuredeploy.paramaters.json' `
-DeploymentDebugLogLevel All -Mode Complete -Force

