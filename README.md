# Introduction 
This project contains a scripted OOTB sitecore 9.0 (Update 1) rev. 171219  installation (9.0.1). Follow the installation steps!

## Changes since 9.0.0 
- Obviously the scripts now rely on the 9.0.1 version of the installation files.
- From now on the installation is performed on the default location of IIS sites, namely c:\inetpub\wwwroot\
This was already so, but now also an addional folder for Solr is added to the wwwroot.
- Solr service name is change to be more in line with the default services. it also contains the port number.
- You can now call install-sitecore.ps using a minimal of configuration and from within external repo's, as long as you have the sitecore9 repo and the correct branch.

# Getting Started
## machine Prerequisites
Make sure to prepare your machine with the prerequisites from the Sitecore installation guide:
1. Sql server 2016 with SP1 
	- Default configuration has the following settings:
		- Sql server instance: sql2016
		- SA Username: your SQL account name	
		- SA Password: Your SQL account password
2. Java JRE 8 x64
3. IIS rewrite module

## To-Do 
The Java check version might fail. Need to check this

## Preparation steps
1. Download the Sitecore 9.0.1 (or any 9.x version)  files and the XP0 configuration files. Unzip them to <root>\localLib. This should result in in two new zipfiles and five jsonfiles. Alternatively you can download the complete localLib folder from the Sitecore Competence teams Onedrive location: <Local Onedrive folder>\Sitecore 9\Sitecore 9.0.1 localLib
2. Copy the licence file to <root>\localLib
3. From PowerShell (run as administrator) execute <root>\scripts\installation\install-prerequisites.ps1

## Install Sitecore
The script will install Sitecore in the sandbox folder. It also install a solr instance in the sandbox folder listening to the configured port.

1. Make a copy of <root>\script\installation\sample-sitecore9-installation.ps1. This file contains the commando. You can overwrite additional parameters in the commando. Please check the top part of <root>\script\installation\install-sitecore.ps1 for the parameters.
2. Execute <root>\script\installation\sample-sitecore9-installation.ps1 or your own copy. During about 10 minutes it will install Solr Sitecore and XConnect. 

Happy days!

# Helpful commando's
- Execute the start script:
	'.\sample-sitecore9-installation.ps1'
- Remove installed service via nssm: 'nssm remove "{Name of the service}" confirm'
	
# Removing a site.
We haven't made it easy to remove sites, yet. These are the steps to remove a site.
1. Stop all services related to your site.
2. Use ps: 'nssm remove "{Name of the service}" confirm' to remove each service.
3. Remove the IIS sites.
4. Remove all databases via SQL management studio.
5. Remove the folders from the file system.
Now you should have completely removed the site.