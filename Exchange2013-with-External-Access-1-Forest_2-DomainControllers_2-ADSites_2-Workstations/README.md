# Exchange 2013 Lab with External Access

Click a button below to deploy to the cloud of your choice

[![Deploy To Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Felliottfieldsjr%2FKillerHomeLab%2Fmaster%2FExchange2013-with-External-Access-1-Forest_2-DomainControllers_2-ADSites_2-Workstations%2Fazuredeploy.json)
[![Deploy To Azure US Gov](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.svg?sanitize=true)](https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Felliottfieldsjr%2FKillerHomeLab%2Fmaster%2FExchange2013-with-External-Access-1-Forest_2-DomainControllers_2-ADSites_2-Workstations%2Fazuregovdeploy.json)

This Templates deploys a Single Forest/Domain:

- 1 - Active Directory Forest/Domain
- 2 - Active Directory Sites
- 2 - Domain Controllers (1 within each AD Site)
- 1 - Offline Root Certificate Authority Server
- 1 - Issuing Certificate Authority Server
- 1 - Online Certificate Status Protocol Server
- 1 - Exchange 2013 Organization
- 2 - Exchange 2013 Servers (1 within each AD Site)
- 2 - File Share Witness Servers (1 within each AD Site)
- 1 - Database Availability Group
- 2 - Domain Joined Windows 10 Workstations (1 within each AD Site)
- 1 - Azure DNS Zone (Created based on NetBiosDomain and TLD Parameters)
- 2 - Network Security Groups (1 Created in each Region)

The deployment also makes the following customizations:
- Adds Public IP Address to OCSP and Exchange Servers.
- Creates Azure DNS Zone Records based on the correesponding Servers Public IP
- -- OCSP (OCSP VM Public IP)
- -- OWA2013 (Exchange VM1 Public IP)
- -- OWA2013 (Exchange VM2 Public IP)
- -- AUTODISCOVER2013 (Exchange VM1 Public IP)
- -- AUTODISCOVER2013 (Exchange VM2 Public IP)
- -- OUTLOOK2013 (Exchange VM1 Public IP)
- -- OUTLOOK2013 (Exchange VM2 Public IP)
- -- EAS2013 (Exchange VM1 Public IP)
- -- EAS2013 (Exchange VM2 Public IP)
- -- SMTP (Exchange VM1 Public IP)
- -- SMTP (Exchange VM2 Public IP)

The deployment leverages Desired State Configuration scripts to further customize the following:

AD OU Structure:
- [domain.com]
- -- Accounts
- --- End User
- ---- Office 365
- ---- Non-Office 365
- --- Admin
- --- Service
- -- Groups
- --- End User
- --- Admin
- -- Servers
- --- Servers2012R2
- --- Serverrs2016
- --- Servers2019
- -- MaintenanceServers
- -- MaintenanceWorkstations
- -- Workstations
- --- Windows10
- --- Windows7

AD DNS Zone Record Creation:
- CRL (For CRL Download)
- OCSP (For OCSP Server)
- OWA2013 (For Exchange Server1)
- OWA2013 (For Exchange Server2)
- AUTODISCOVER2013 (For Exchange Server1)
- AUTODISCOVER2013 (For Exchange Server2)
- OUTLOOK2013 (For Exchange Server1)
- OUTLOOK2013 (For Exchange Server2)
- EAS2013 (For Exchange Server1)
- EAS2013 (For Exchange Server2)
- SMTP (For Exchange Server1)
- SMTP (For Exchange Server2)

PKI
- Offline Root CA Configuaration
- Issuing CA Configuration
- OCSP Configuaration

Exchange
- File Share Witness Creation
- Exchange 2013 OS Prerequisites
- Exchange 2013 Installation
- Request/Receive Exchange 2013 SAN Certificate from Issuing CA
- Exchange 2013 Certificate Enablement
- Exchange Virtual Directory Internal/External Configuration
- Exchange Virtual Directory Authentication Configuration
- DAG Creation and Adding both Exchange Servers

Parameters that support changes
- Exchange Org Name. Enter a name that will be used for your Exchange Organization Name.
- Exchange2013ISOUrl.  You must enter a URL or created SAS URL that points to an Exchange 2013 ISO for this installation to be successful.
- Exchange2013CUEXEUrl.  You must enter a URL or created SAS URL that points to an Exchange 2016 CU EXE for this installation to be successful.
- Admin Username.  Enter a valid Admin Username
- Admin Password.  Enter a valid Admin Password
- To Email.  Please provide a working email address that the Trusted Certificate Authority Chain Can be sent to.  These certificates will allow access to Exchange Services like OWA, EAS and Outlook without Certificate Security warnings. (Depending on What Public IP you get initially.  Exchange mailflow may be blocked if it's blacklisted)
- Location1. Enter a Valid Azure Region based on which Cloud (AzureCloud, AzureUSGovernment, etc...) you are using.
- Location2. Enter a Valid Azure Region based on which Cloud (AzureCloud, AzureUSGovernment, etc...) you are using.
- Naming Convention. Enter a name that will be used as a naming prefix for (Servers, VNets, etc) you are using.
- Net Bios Domain.  Enter a valid Net Bios Domain Name (Example:  killerhomelab).
- TLD.  Select a valid Top-Level Domain using the Pull-Down Menu.
- Vnet1ID.  Enter first 2 octets of your desired Address Space for Virtual Network 1 (Example:  13.1)
- Vnet2ID.  Enter first 2 octets of your desired Address Space for Virtual Network 2 (Example:  13.2)
- Reverse Lookup1.  Enter first 2 octets of your desired Address Space in Reverse (Example:  1.13)
- Reverse Lookup2.  Enter first 2 octets of your desired Address Space in Reverse (Example:  2.13)
- Root CA Name.  Enter a Name for your Root Certificate Authority
- Issuing CA Name.  Enter a Name for your Issuing Certificate Authority
- DC1OSVersion.  Select 2016-Datacenter (Windows 2016) or 2019-Datacenter (Windows 2019) Domain Controller 1 OS Version
- DC2OSVersion.  Select 2016-Datacenter (Windows 2016) or 2019-Datacenter (Windows 2019) Domain Controller 2 OS Version
- RCAOSVersion.  Select 2016-Datacenter (Windows 2016) or 2019-Datacenter (Windows 2019) Root CA OS Version
- ICAOSVersion.  Select 2016-Datacenter (Windows 2016) or 2019-Datacenter (Windows 2019) Issuing CA OS Version
- OCSPOSVersion.  Select 2016-Datacenter (Windows 2016) or 2019-Datacenter (Windows 2019) OCSP OS Version
- FSOSVersion.  Select 2016-Datacenter (Windows 2016) or 2019-Datacenter (Windows 2019) File ShareWiteness OS Version
- EXOSVersion.  Exchange Servers OS Version is not configurable and set to 2012-R2-Datacenter (Windows 2012 R2).
- WK1OSVersion.  Workstation1 OS Version is not configurable and set to 19h1-pro (Windows 10).
- WK2OSVersion.  Workstation2 OS Version is not configurable and set to 19h1-pro (Windows 10).
- DC1VMSize.  Enter a Valid VM Size based on which Region the VM is deployed.
- DC2VMSize.  Enter a Valid VM Size based on which Region the VM is deployed.
- RCAVMSize.  Enter a Valid VM Size based on which Region the VM is deployed.
- ICAVMSize.  Enter a Valid VM Size based on which Region the VM is deployed.
- OCSPVMSize.  Enter a Valid VM Size based on which Region the VM is deployed.
- FS1VMSize.  Enter a Valid VM Size based on which Region the VM is deployed.
- EX1VMSize.  Enter a Valid VM Size based on which Region the VM is deployed.
- WK1VMSize.  Enter a Valid VM Size based on which Region the VM is deployed.
- FS2VMSize.  Enter a Valid VM Size based on which Region the VM is deployed.
- EX2VMSize.  Enter a Valid VM Size based on which Region the VM is deployed.
- WK2VMSize.  Enter a Valid VM Size based on which Region the VM is deployed.