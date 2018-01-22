Param(
    [Parameter( Mandatory = $true)]
    $installFolder,
    [Parameter( Mandatory = $true)]
    $solrServiceName,
    [Parameter( Mandatory = $false)]
    $solrVersion = "6.6.2",
    [Parameter( Mandatory = $false)]
    $solrPort = "8983"    
)

Set-ExecutionPolicy -ExecutionPolicy Unrestricted 
Clear-Host

. $PSScriptRoot/modules/functions.ps1

write-host "jre version= $JREVersion, $installFolder, $solrPort, $solrServiceName"
$start_time = Get-Date
. $PSScriptRoot/modules/Install-Solr.ps1 -JREVersion $JREVersion -installFolder $installFolder -solrPort $solrPort -solrServiceName $solrServiceName

Write-Output "Created Solr Certificate in $((Get-Date).Subtract($start_time).Seconds) second(s)"

