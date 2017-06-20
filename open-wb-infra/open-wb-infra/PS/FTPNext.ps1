## Import IIS module 
Import-Module WebAdministration


## Get VM Public IP

# Function to resolve VM public fqdn 
function Resolve-DnsName2008
{
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$Name,
        [string]$Server = '8.8.8.8'
    )
    Try
    {
        $nslookup = &nslookup.exe $Name $Server
        $regexipv4 = "^(?:(?:0?0?\d|0?[1-9]\d|1\d\d|2[0-5][0-5]|2[0-4]\d)\.){3}(?:0?0?\d|0?[1-9]\d|1\d\d|2[0-5][0-5]|2[0-4]\d)$"

        $name = @($nslookup | Where-Object { ( $_ -match "^(?:Name:*)") }).replace('Name:','').trim()

        $deladdresstext = $nslookup -replace "^(?:^Address:|^Addresses:)",""
        $Addresses = $deladdresstext.trim() | Where-Object { ( $_ -match "$regexipv4" ) }

        $total = $Addresses.count
        $AddressList = @()
        for($i=1;$i -lt $total;$i++)
        {
            $AddressList += $Addresses[$i].trim()
        }

        $AddressList | %{

        new-object -typename psobject -Property @{
            Name = $name
            IPAddress = $_
            }
        }
    }
    catch 
    { }
}

# Get VM public fqdn   
$vmPublicName = $env:COMPUTERNAME + ".westeurope.cloudapp.azure.com"

# Get VM public IP using function 
$vmPublicIP = (Resolve-DNSName2008 -Name $vmPublicName).IPAddress
$extIP = $vmPublicIP.Substring(0,$vmPublicIP.Length)


## Create FTP

# Create Ftp site with default home directory c:\inetpub\ftproot
New-WebFtpSite -Name appUpload -Port 21 -PhysicalPath C:\inetpub\ftproot


## Configure appropriate settings
  
# Enable basic authentication 
Set-ItemProperty "IIS:\Sites\appUpload" -Name ftpServer.security.authentication.basicAuthentication.enabled -Value $true

# Allow non-SSL connections 
Set-ItemProperty "IIS:\Sites\appUpload" -Name ftpServer.security.ssl.controlChannelPolicy -Value 0 
Set-ItemProperty "IIS:\Sites\appUpload" -Name ftpServer.security.ssl.dataChannelPolicy -Value 0
 
# Allow Read-Write access for Administrators group 
Add-WebConfiguration system.ftpServer/security/authorization "IIS:\" -Value @{accessType="Allow";roles="Administrators";permissions="Read,Write"}

# Configure ftp passive mode
Set-WebConfiguration system.ftpServer/firewallSupport "IIS:\" -Value @{lowDataChannelPort="5000";highDataChannelPort="5014"}
Set-WebConfiguration system.applicationHost/sites/siteDefaults/ftpServer/firewallSupport "IIS:\" -Value @{externalIp4Address=$extIP}
 
# Restart Ftp service for all changes to take effect
net stop ftpsvc
net start ftpsvc 