#
# DeployTemplate.ps1
#
# The script creates resource group and deploy ARM template
#
Add-AzureRmAccount
$DeployIndex = "121"
$ResourceGroupName = "Open-RG" + $DeployIndex
$ResourceGroupLocation = "westeurope"
$OpenDeploymentName = "Open-Dep" + $DeployIndex
# $TemplateFile = "C:\Users\ashapo\Work Folders\DPE\VS\OpenArm\open-wb\open-wb-infra\open-wb-infra\openwbVMs.json"
# $TemplateParametersFile = "C:\Users\ashapo\Work Folders\DPE\VS\OpenArm\open-wb\open-wb-infra\open-wb-infra\openwbVMs.parameters.json"
# $TemplateFile = "C:\Users\ashapo\Work Folders\DPE\VS\OpenArm\open-wb\open-wb-infra\open-wb-infra\sqlVM.json"
# $TemplateParametersFile = "C:\Users\ashapo\Work Folders\DPE\VS\OpenArm\open-wb\open-wb-infra\open-wb-infra\sqlVM.parameters.json"
# $TemplateFile = "C:\Users\ashapo\Work Folders\DPE\VS\OpenArm\open-wb\open-wb-infra\open-wb-infra\sqlMultiVMs.json"
# $TemplateParametersFile = "C:\Users\ashapo\Work Folders\DPE\VS\OpenArm\open-wb\open-wb-infra\open-wb-infra\sqlMultiVMs.parameters.json"
# $TemplateFile = "C:\Users\ashapo\Work Folders\DPE\VS\OpenArm\open-wb\open-wb-infra\open-wb-infra\gateVMSS.json"
# $TemplateParametersFile = "C:\Users\ashapo\Work Folders\DPE\VS\OpenArm\open-wb\open-wb-infra\open-wb-infra\gateVMSS.parameters.json"
# $TemplateFile = "C:\Users\ashapo\Work Folders\DPE\VS\OpenArm\open-wb\open-wb-infra\open-wb-infra\gateSS.json"
# $TemplateParametersFile = "C:\Users\ashapo\Work Folders\DPE\VS\OpenArm\open-wb\open-wb-infra\open-wb-infra\gateSS.parameters.json"
# $TemplateFile = "C:\Users\ashapo\Work Folders\DPE\VS\OpenArm\open-wb\open-wb-infra\open-wb-infra\loadVM.json"
# $TemplateParametersFile = "C:\Users\ashapo\Work Folders\DPE\VS\OpenArm\open-wb\open-wb-infra\open-wb-infra\loadVM.parameters.json"
# $TemplateFile = "C:\Users\ashapo\Work Folders\DPE\VS\OpenArm\open-wb\open-wb-infra\open-wb-infra\stubVM.json"
# $TemplateParametersFile = "C:\Users\ashapo\Work Folders\DPE\VS\OpenArm\open-wb\open-wb-infra\open-wb-infra\stubVM.parameters.json"

$TemplateFile = "C:\Users\ashapo\Work Folders\DPE\VS\OpenArm\open-wb\open-wb-infra\open-wb-infra\openWb.json"
$TemplateParametersFile = "C:\Users\ashapo\Work Folders\DPE\VS\OpenArm\open-wb\open-wb-infra\open-wb-infra\openWb.parameters.json"

New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation -Verbose -Force

New-AzureRmResourceGroupDeployment -Name $OpenDeploymentName `
                                       -ResourceGroupName $ResourceGroupName `
                                       -TemplateFile $TemplateFile `
                                       -TemplateParameterFile $TemplateParametersFile `
                                       -Verbose `

