
####################### VERSION CHECK (do not remove) ###################################################
Write-Output "Checking for version updates..."
$skip_update = $false
# Retrieve status file from Github 
$stat = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Mbesad/UCScript/main/UCScript_status" -TimeoutSec 10
$stat_content = $stat.Content
$stat_content = $stat_content.split([Environment]::NewLine)
$newver = $null
# Search for script version in the status file
ForEach ($element in $stat_content)
{
    if ($element -like "Version=*"){$newver = $element.split('=')[1]} 
}
If ($newver -eq $null)
{
Write-Output "Could not get current version on Github. Continuing..."
$skip_update = $true
}
# Retrieve status file from local machine
$curr_status_file = Get-Content .\UCScript_status.txt -Raw
$curr_status_file = $curr_status_file.split([Environment]::NewLine)
# Search for script version in the status file
ForEach ($element in $curr_status_file)
{
    if ($element -like "Version=*"){$currver = $element.split('=')[1]} 
}
If ($currver -eq $null){
Write-Output "Could not get current version on local machine. Continuing..."
$skip_update = $true
}

#Compare versions#
if (!$skip_update)
{
$newver = $newver.split('.')
$currver = $currver.split('.')
if ($newver[0] -lt $currver[0]) {$skip_update = $true}
if (($newver[0] -eq $currver[0]) -And ($newver[1] -lt $currver[1])) {$skip_update = $true}
if (($newver[0] -eq $currver[0]) -And ($newver[1] -eq $currver[1]) -And ($newver[2] -le $currver[2])) {$skip_update = $true}
}

if (!$skip_update)
{
$title = 'Update Available'
$Message = 'A newer version of this script is available on Github. Would you like to update it?'
$yes = New-Object -TypeName System.Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes', 'Download the newer version and update the script.'
$no = New-Object -TypeName System.Management.Automation.Host.ChoiceDescription -ArgumentList '&No', 'No, thanks.'
$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
$skip_update = $host.ui.PromptForChoice($title, $Message, $options, 0) 

}

if (!$skip_update)
{
#Retrieve new source code
Write-Host "Updating..." -ForegroundColor green
$script_file = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Mbesad/UCScript/main/UCScript.ps1" -TimeoutSec 10 
$code = $script_file.Content
# Replace source code
$code| Set-Content .\UCScript.ps1
$stat_content| Set-Content .\UCScript_status.txt
Write-Host "Update complete. Please re-run." -ForegroundColor green
Exit
}
else 
{
Write-Output "Continuing..."
}
###################################################################################################################

################################################ SCRIPT BEGINS ####################################################
write-Host " "
write-Host "--------------------------------------"
write-Host "Script begins" -ForegroundColor green
Write-Host "A script here..." 
Write-Host "Version 2.1.4" 

###################################################################################################################

# SIG # Begin signature block
# MIIFdgYJKoZIhvcNAQcCoIIFZzCCBWMCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUi/mdiWZ27NpG3+N5yrEy5YaS
# If+gggMOMIIDCjCCAfKgAwIBAgIQHwtBe56H8LJP+qjpIFCEVTANBgkqhkiG9w0B
# AQUFADAdMRswGQYDVQQDDBJMb2NhbCBDb2RlIFNpZ25pbmcwHhcNMjEwMjIzMjEy
# MDM1WhcNMjIwMjIzMjE0MDM1WjAdMRswGQYDVQQDDBJMb2NhbCBDb2RlIFNpZ25p
# bmcwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDZdn2zaZXh7wQY0OxR
# 5s8/WSp6BlQivZdqqmAE/NvCzclTnDVjN4QXEHim6acoswfQ+1fJ5/izCJM2OqNy
# /qnxpBsqDkrPZL3ZMKHwR0p1PCzTQpnDk1Jq6pUbjFrqXGiQfbrCNI9uEepMKNMw
# 2um2VTdPA3cB9LLrXSaXoUpGXT7Un22RVfQuOpCUzzYRCS3QenaidFA99nD48fwn
# Y5fa3UArBvcGg4b2vjVkaPepZSg+u99QR5wOCbUUYYHs1+Vy/IV9zqURrNTY3X2s
# u16hn/DZdMdZuFVKh1+f8a8YP7KjXjvOUGnVccDjQc6yJfJqxnFMFt7BLcjNnea1
# 4Uu5AgMBAAGjRjBEMA4GA1UdDwEB/wQEAwIHgDATBgNVHSUEDDAKBggrBgEFBQcD
# AzAdBgNVHQ4EFgQUe94H2YQF6oo8uDc6O9/oJshyBXcwDQYJKoZIhvcNAQEFBQAD
# ggEBAMLGXC4FcVtr+HAw4gyHVW/IiYBPl4sDqdgGqvidm+K1i81zMDE6slcrhUpK
# xu1Wq9jQCnkmCOus2z37DuBZCWUS2uznThQxG75OaHTxoCmlpo7SZ3VPF3LJFToz
# JhqJ3zfzvI85wYyYPW6Tg+zq78DFB7KcZRS0gMiTrTem7NPNUg6NPCgFdIWvSA0c
# MVdpqQ2Tr8dsYUeQcAsfgkpDltg8PFu1duE1vk/KxKsx77uJDP2/QCyuoqSVcovS
# R2V2ApzenVYY9viIOzVcgMCXyobuj9Okr8JeL8Lp6qPLQEcV1rBxIEdgfl3Of72H
# 9Jzrw5G9w49dax7x2pMRU+zakpkxggHSMIIBzgIBATAxMB0xGzAZBgNVBAMMEkxv
# Y2FsIENvZGUgU2lnbmluZwIQHwtBe56H8LJP+qjpIFCEVTAJBgUrDgMCGgUAoHgw
# GAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGC
# NwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQx
# FgQUmzlBTRzgf5C9u0gZuVqx/I9+9hQwDQYJKoZIhvcNAQEBBQAEggEAiylJZ7HP
# +75yiOWsZfPx1/JNe/VMor7qmA8u1N9Otk2vOWcXFdud0muTj3PEZRl7Z5uWeC3l
# vVBoEEf6qXG70QWNbpJmWCcsFrpU5QNPM+kUGAFjQwFgzNRFmg5ANRDOb3i1G8NZ
# 8J7G+dov3voDNyf9CQUpACcxKiOSwDDDyPxlRcNPlXUBSWt1HnCdqAllZABGlwoh
# 5KVe/r8Yd2YBp8Z5Cq3H8iQCFjVpqteDGaz1AtFz4ryEspmqyVIFjW9yIdRoY6sd
# LbmyrLzjxVeJiv1K6ixV6xsdRvqRQtNCp3ftLdq9g7eb27R4pfnj/ogZMAfoKN83
# T2MRWuIugjl1jw==
# SIG # End signature block
