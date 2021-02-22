
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
#Retrieve new source code
$script_file = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Mbesad/UCScript/main/UCScript.ps1" -TimeoutSec 10 
$code = $script_file.Content
# Replace source code
$code| Set-Content .\UCScript.ps1
$stat_content| Set-Content .\UCScript_status.txt
Write-Output "Script updated. Please run again."
}
else 
{
Write-Output "No update available. Continuing..."
}
###################################################################################################################
################################################ SCRIPT BEGINS ####################################################

# Code 2.1.1
