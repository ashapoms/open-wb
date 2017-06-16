#
# IIS.ps1
#
# The configuration to install Web Server role with ASP.NET, FTP features and management console 
#
configuration IISInstall 
{ 
    node "localhost"
    { 
        WindowsFeature IISServer 
        { 
            Ensure = "Present" 
            Name = "Web-Server"                       
        } 

        WindowsFeature ASPNET 
        { 
            Ensure = "Present" 
            Name = "Web-Asp-Net"                       
        }
        
        WindowsFeature FTP
        {
            Ensure = "Present"
            Name = "Web-Ftp-Server"
            IncludeAllSubFeature = $true
        }		
    } 
}