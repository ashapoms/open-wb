 ##    NEEDED FOR IIS CMDLETS
Import-Module WebAdministration

##    CREATE FTP SITE AND SET C:\inetpub\ftproot AS HOME DIRECTORY
New-WebFtpSite -Name "test" -Port "21" -Force
cmd /c \Windows\System32\inetsrv\appcmd set SITE "test" "-virtualDirectoryDefaults.physicalPath:C:\inetpub\ftproot"

##    SET PERMISSIONS

     ## Allow SSL connections 
Set-ItemProperty "IIS:\Sites\test" -Name ftpServer.security.ssl.controlChannelPolicy -Value 0
Set-ItemProperty "IIS:\Sites\test" -Name ftpServer.security.ssl.dataChannelPolicy -Value 0

     ## Enable Basic Authentication
Set-ItemProperty "IIS:\Sites\test" -Name ftpServer.security.authentication.basicAuthentication.enabled -Value $true
## Set USer Isolation
 Set-ItemProperty "IIS:\Sites\test" -Name ftpserver.userisolation.mode -Value 3

#Set-ItemProperty "IIS:\Sites\test" -Name ftpServer.security.userIsolation. -Value $true

     ## Give Authorization to All Users and grant "read"/"write" privileges
Add-WebConfiguration "/system.ftpServer/security/authorization" -value @{accessType="Allow";roles="";permissions="Read,Write";users="*"} -PSPath IIS:\ -location "test"
## Give Authorization to All Users using CMD
#appcmd set config %ftpsite% /section:system.ftpserver/security/authorization /+[accessType='Allow',permissions='Read,Write',roles='',users='*'] /commit:apphost 

     ## Restart the FTP site for all changes to take effect
Restart-WebItem "IIS:\Sites\test"