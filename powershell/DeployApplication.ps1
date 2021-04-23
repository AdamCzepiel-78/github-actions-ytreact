Import-Module WebAdministration

$iisAppPoolName = "ReactPool"  
$iisAppPoolDotNetVersion = "v4.0"  
  
$iisWebsiteFolderPath = "$(Get-Location)\build"  
$iisWebsiteName = "ReactApp"  

# Website Bindings 
$iisWebsiteBindings = @(  
   @{protocol="http";bindingInformation="*:8000:"}  
)  
  
## check and create app-pool if not exists 
if (!(Test-Path IIS:\AppPools\$iisAppPoolName -pathType container))  
{  
New-Item IIS:\AppPools\$iisAppPoolName  
Set-ItemProperty IIS:\AppPools\$iisAppPoolName -name "managedRuntimeVersion" -value $iisAppPoolDotNetVersion  
}

## remove old website version 
if(!(Test-Path IIS:\Sites\$iisWebsiteName -pathType container)){
   Remove-Item IIS:\Sites\$iisWebsiteName -Confirm:$false
}

## deploy new webseite version 
New-Item IIS:\Sites\$iisWebsiteName -bindings $iisWebsiteBindings -physicalPath $iisWebsiteFolderPath -Force
Set-ItemProperty IIS:\Sites\$iisWebsiteName -name applicationPool -value $iisAppPoolName  
