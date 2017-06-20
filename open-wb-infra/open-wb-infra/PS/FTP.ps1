# Import IIS module 
Import-Module WebAdministration

# Create Ftp site with default home directory c:\inetpub\ftproot
New-WebFtpSite -Name appUpload -Port 21 -PhysicalPath C:\inetpub\ftproot

# Configure appropriate settings  
# Enable basic authentication 
Set-ItemProperty "IIS:\Sites\appUpload" -Name ftpServer.security.authentication.basicAuthentication.enabled -Value $true

# Allow not SSL connections 
Set-ItemProperty "IIS:\Sites\appUpload" -Name ftpServer.security.ssl.controlChannelPolicy -Value 0 
Set-ItemProperty "IIS:\Sites\appUpload" -Name ftpServer.security.ssl.dataChannelPolicy -Value 0
 
# Allow Read-Write access for Administrators group 
Add-WebConfiguration system.ftpServer/security/authorization "IIS:\" -Value @{accessType="Allow";roles="Administrators";permissions="Read,Write"}
 
# Restart Ftp site for all changes to take effect
# Restart-WebItem "IIS:\Sites\appUpload"