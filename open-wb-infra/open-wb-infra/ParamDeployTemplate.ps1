#
# ParamDeployTemplate.ps1
#

Param(
	[string] $ResourceGroupLocation = "westeurope",
	[string] $DeployIndex = "01",
	[string] $ResourceGroupPrefix = "Open-RG",
	[string] $AzureUserName = "<admin login>@<tenant name>.onmicrosoft.com",
	[string] $AzureUserPassword = "<Azure admin password>"
)

$AadPass = ConvertTo-SecureString $AzureUserPassword -AsPlainText -Force
$AadCred = New-Object System.Management.Automation.PSCredential ($AzureUserName, $Aadpass)
Login-AzureRmAccount -Credential $AadCred

$ResourceGroupName = $ResourceGroupPrefix + $DeployIndex
$DeploymentName = $ResourceGroupPrefix + "-Dep" + $DeployIndex
$TemplateFile = "<Path to template>\<template file>.json"
$TemplateParametersFile = "<Path to template parameters>\<template parameters file>.parameters.json"

New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation -Verbose -Force

New-AzureRmResourceGroupDeployment -Name $DeploymentName `
                                       -ResourceGroupName $ResourceGroupName `
                                       -TemplateFile $TemplateFile `
                                       -TemplateParameterFile $TemplateParametersFile `
                                       -Verbose
