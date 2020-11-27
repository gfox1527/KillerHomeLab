﻿configuration SQLACCOUNTS
{
   param
   (
        [String]$DomainName,        
        [String]$BaseDN,
        [String]$NetBiosDomain,
        [System.Management.Automation.PSCredential]$Admincreds
    )

    Import-DscResource -Module ActiveDirectoryDsc

    [System.Management.Automation.PSCredential ]$DomainCreds = New-Object System.Management.Automation.PSCredential ("${NetBiosDomain}\$($Admincreds.UserName)", $Admincreds.Password)

    Node localhost
    {
        ADUser Install
        {
            Ensure     = 'Present'
            UserName   = "Install"
            DomainName = $DomainName
            Path       = "OU=Service,OU=Accounts,$BaseDN"
            Password = $DomainCreds
            Enabled = $True
        }

        ADUser SQLSvc1
        {
            Ensure     = 'Present'            
            UserName   = "SQLSvc1"
            DomainName = $DomainName
            Path       = "OU=Service,OU=Accounts,$BaseDN"
            Password = $DomainCreds
            Enabled = $True
        }

        ADUser SQLSvc2
        {
            Ensure     = 'Present'            
            UserName   = "SQLSvc2"
            DomainName = $DomainName
            Path       = "OU=Service,OU=Accounts,$BaseDN"
            Password = $DomainCreds
            Enabled = $True
        }
        Script GrantCreateComputerAccounts
        {
            SetScript =
            {

                $acl = get-acl "ad:$using:BaseDN"
                $User = Get-ADUser Install

                # The following object specific ACE is to grant Group permission to change user password on all user objects under OU
                $objectguid = new-object Guid bf967a86-0de6-11d0-a285-00aa003049e2 # is the rightsGuid for the extended right Create Computer Account
                $inheritedobjectguid = new-object Guid $User.ObjectGUID # is the schemaIDGuid for the user
                $identity = [System.Security.Principal.IdentityReference] $User.SID
                $adRights = [System.DirectoryServices.ActiveDirectoryRights] "GenericAll"
                $type = [System.Security.AccessControl.AccessControlType] "Allow"
                $inheritanceType = [System.DirectoryServices.ActiveDirectorySecurityInheritance] "All"
                $ace = new-object System.DirectoryServices.ActiveDirectoryAccessRule $identity,$adRights,$type,$objectGuid,$inheritanceType,$inheritedobjectguid
                $acl.AddAccessRule($ace)
                Set-acl -aclobject $acl "ad:$using:BaseDN"
            }
            GetScript =  { @{} }
            TestScript = { $false}
            DependsOn = '[ADUser]Install'
        }

    }
}

$configData = @{
                AllNodes = @(
                              @{
                                 NodeName = 'localhost';
                                 PSDscAllowPlainTextPassword = $true
                                    }
                    )
               }