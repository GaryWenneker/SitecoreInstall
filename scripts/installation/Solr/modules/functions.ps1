

$javaVersions = (Get-ChildItem "C:\Program Files\Java\jre*\bin\java.exe").VersionInfo.FileName

#if($javaVersions.length -gt 1){
#    $JREVersion = $javaVersions[0]
#} else {
#    $JREVersion = $javaVersions
#}
$JREVersion = $javaVersions

$JREVersion = "$JREVersion".Replace("C:\Program Files\Java\jre", "").Replace("\bin\java.exe", "")
Write-Host "JRE current version = $JREVersion"

