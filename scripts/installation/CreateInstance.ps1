#define parameters 

Param(
    [Parameter( Mandatory = $true)]
    $prefix,
    [Parameter( Mandatory = $true)]
    $solrUrl,
    [Parameter( Mandatory = $true)]
    $solrRoot,
    [Parameter( Mandatory = $true)]
    $solrService,
    [Parameter( Mandatory = $true)]
    $sqlServer,
    [Parameter( Mandatory = $true)]
    $sqlAdminUser,
    [Parameter( Mandatory = $true)]
    $sqlAdminPassword,
	[Parameter( Mandatory = $false)]
	$sitecoreVersion = "9.0.1"
)

#define parameters
$XConnectCollectionService = "$prefix.xconnect"
$sitecoreSiteName = "$prefix.local"
$sitecoreVersion900Name = "Sitecore 9.0.0 rev. 171002"
$sitecoreVersion901Name = "Sitecore 9.0.1 rev. 171219"
$sitecoreVersionName = "Sitecore 9.0.1 rev. 171219"
if($sitecoreVersion -eq "9.0.1"){
	$sitecoreVersionName = $sitecoreVersion901Name
}
else{
	$sitecoreVersionName = $sitecoreVersion900Name
}
$PSScriptRoot = (Resolve-Path ./../../localLib/$sitecoreVersion)

#install client certificate for xconnect 
$certParams = 
@{     
    Path = "$PSScriptRoot\xconnect-createcert.json"     
    CertificateName = "$prefix.xconnect_client" 
} 
Install-SitecoreConfiguration @certParams -Verbose

#install solr cores for xdb 
$solrParams = 
@{
    Path = "$PSScriptRoot\xconnect-solr.json"     
    SolrUrl = $solrUrl    
    SolrRoot = $solrRoot  
    SolrService = $solrService  
    CorePrefix = $prefix 
} 
Install-SitecoreConfiguration @solrParams -Verbose

#deploy xconnect instance 
$xconnectParams = 
@{
    Path = "$PSScriptRoot\xconnect-xp0.json"     
    Package = "$PSScriptRoot\$sitecoreVersionName (OnPrem)_xp0xconnect.scwdp.zip"
    LicenseFile = "$PSScriptRoot\license.xml"
    Sitename = $XConnectCollectionService   
    XConnectCert = $certParams.CertificateName    
    SqlDbPrefix = $prefix  
    SqlServer = $sqlServer  
    SqlAdminUser = $sqlAdminUser
    SqlAdminPassword = $sqlAdminPassword
    SolrCorePrefix = $prefix
    SolrURL = $solrUrl      
} 
Install-SitecoreConfiguration @xconnectParams -Verbose

#install solr cores for sitecore 
$solrParams = 
@{
    Path = "$PSScriptRoot\sitecore-solr.json"
    SolrUrl = $solrUrl
    SolrRoot = $solrRoot
    SolrService = $solrService     
    CorePrefix = $prefix 
} 
Install-SitecoreConfiguration @solrParams -Verbose
 
#install sitecore instance 
$sitecoreParams = 
@{     
    Path = "$PSScriptRoot\sitecore-XP0.json"
    Package = "$PSScriptRoot\$sitecoreVersionName (OnPrem)_single.scwdp.zip" 
    LicenseFile = "$PSScriptRoot\license.xml"
    SqlDbPrefix = $prefix  
    SqlServer = $sqlServer  
    SqlAdminUser = $sqlAdminUser     
    SqlAdminPassword = $sqlAdminPassword     
    SolrCorePrefix = $prefix  
    SolrUrl = $solrUrl     
    XConnectCert = $certParams.CertificateName     
    Sitename = $sitecoreSiteName 
    XConnectCollectionService = "https://$XConnectCollectionService"    
} 
Install-SitecoreConfiguration @sitecoreParams -Verbose