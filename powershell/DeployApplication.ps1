Import-Module WebAdministration

$iisAppPoolName = "ReactPool"  
$iisAppPoolDotNetVersion = "v4.0"  
  
$iisWebsiteFolderPath = "$(Get-Location)\build"  
$iisWebsiteName = "ReactApp"  
  
$iisWebsiteBindings = @(  
   @{protocol="http";bindingInformation="*:8000"}  
)  
  
if (!(Test-Path IIS:\AppPools\$iisAppPoolName -pathType container))  
{  
New-Item IIS:\AppPools\$iisAppPoolName  
Set-ItemProperty IIS:\AppPools\$iisAppPoolName -name "managedRuntimeVersion" -value $iisAppPoolDotNetVersion  
}  
  
if (!(Test-Path IIS:\Sites\$iisWebsiteName -pathType container))  
{  
New-Item IIS:\Sites\$iisWebsiteName -bindings $iisWebsiteBindings -physicalPath $iisWebsiteFolderPath  
Set-ItemProperty IIS:\Sites\$iisWebsiteName -name applicationPool -value $iisAppPoolName  
}
