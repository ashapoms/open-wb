#
# DeployTemplate.ps1
#
# The script creates resource group and deploy ARM template
#
Add-AzureRmAccount
$ResourceGroupName = "Open-RG101"
$ResourceGroupLocation = "westeurope"
$OpenDeploymentName = "Open-Dep101"
$TemplateFile = "C:\Users\ashapo\Work Folders\DPE\VS\OpenArm\open-wb\open-wb-infra\open-wb-infra\openwbVMs.json"
$TemplateParametersFile = "C:\Users\ashapo\Work Folders\DPE\VS\OpenArm\open-wb\open-wb-infra\open-wb-infra\openwbVMs.parameters.json"

New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation -Verbose -Force


New-AzureRmResourceGroupDeployment -Name $OpenDeploymentName `
                                       -ResourceGroupName $ResourceGroupName `
                                       -TemplateFile $TemplateFile `
                                       -TemplateParameterFile $TemplateParametersFile `
                                       -Verbose `

