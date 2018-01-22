Param(
    [Parameter( Mandatory = $true)]
    $prefix,
    [Parameter( Mandatory = $false)]
    $solrPort = "8984",
    [Parameter( Mandatory = $false)]
    $solrVersion = "6.6.2",
    [Parameter( Mandatory = $false)]
    $sqlServer = ".",
    [Parameter( Mandatory = $false)]
    $sqlAdminUser = "sa",
    [Parameter( Mandatory = $false)]
    $sqlAdminPassword = "yourpassword",
    [Parameter( Mandatory = $false)]
    $installSolr = $true,
	[Parameter( Mandatory = $false)]
	$sitecoreVersion = "9.0.1"
)

#Clear-Host
Set-Location $PSScriptRoot
#You don't have to configure these variables
$websiteRoot = Join-Path "D:" "websites\$prefix"
$solrRoot = "$websiteRoot.solr"
$PSScriptRoot = (Resolve-Path ./../../localLib)
$solrUrl = "https://solr:$solrPort/solr"

# force initial Solr folder
New-Item -ItemType Directory -Force -Path $solrRoot
#New-Item -ItemType Directory -Force -Path "$websiteRoot\solr\solr-$solrVersion"
$solrService = "Sitecore Solr Engine - $prefix Port $solrPort"

#Test is configured port is available
if($installSolr -eq $true){
    if((Test-NetConnection -ComputerName $env:computername -Port $solrPort -InformationLevel Quiet) -eq "true"){
        throw "Solr port already in use. Try another port!"
    }
    #install Solr instance
    . ./Solr/Install-Prerequisites.ps1 -installFolder $solrRoot -solrServiceName $SolrService -solrPort $solrPort -solrVersion $solrVersion
}

#install Sitecore
. ./CreateInstance.ps1 -prefix $prefix -solrUrl $solrUrl -solrRoot "$solrRoot\solr-$solrVersion" -solrService $solrService -sqlServer $sqlServer -sqlAdminUser $sqlAdminUser -sqlAdminPassword $sqlAdminPassword -sitecoreVersion $sitecoreVersion

# finally prove it's all working
Invoke-Expression "start http://$prefix.local/sitecore/login"
