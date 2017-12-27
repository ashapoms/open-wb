#
# DeployTemplate.ps1
#
# The script creates resource group and deploy ARM template
#

$aadpass = ConvertTo-SecureString "<Azure admin password>" -AsPlainText -Force
$aadcred = New-Object System.Management.Automation.PSCredential ("<admin login>@<tenant name>.onmicrosoft.com", $aadpass)

#Add-AzureRmAccount
Login-AzureRmAccount -Credential $aadcred
$DeployIndex = "201"
$ResourceGroupName = "Open-RG" + $DeployIndex
$ResourceGroupLocation = "westeurope"
$OpenDeploymentName = "Open-Dep" + $DeployIndex
$TemplateFile = "<Path to template>\<template file>.json"
$TemplateParametersFile = "<Path to template parameters>\<template parameters file>.parameters.json"

New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation -Verbose -Force

New-AzureRmResourceGroupDeployment -Name $OpenDeploymentName `
                                       -ResourceGroupName $ResourceGroupName `
                                       -TemplateFile $TemplateFile `
                                       -TemplateParameterFile $TemplateParametersFile `
                                       -Verbose 