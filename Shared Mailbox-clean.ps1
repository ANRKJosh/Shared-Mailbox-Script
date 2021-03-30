#This will self elevate the script so with a UAC prompt since this script needs to be run as an Administrator in order to function properly.
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Write-Host "The Shared Mailbox Script will now open in PowerShell with Administrator Privilages, as you did not run the script as an Administrator or in ISE."
    Start-Sleep 1
    Write-Host "                                               3"
    Start-Sleep 1
    Write-Host "                                               2"
    Start-Sleep 1
    Write-Host "                                               1"
    Start-Sleep 1
    Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit
}

cls
Write-Host "................................................................................................................."
Write-Host "..%%%%...%%..%%...%%%%...%%%%%...%%%%%%..%%%%%...........%%...%%...%%%%...%%%%%%..%%......%%%%%....%%%%...%%..%%."
Write-Host ".%%......%%..%%..%%..%%..%%..%%..%%......%%..%%..........%%%.%%%..%%..%%....%%....%%......%%..%%..%%..%%...%%%%.."
Write-Host "..%%%%...%%%%%%..%%%%%%..%%%%%...%%%%....%%..%%..........%%.%.%%..%%%%%%....%%....%%......%%%%%...%%..%%....%%..."
Write-Host ".....%%..%%..%%..%%..%%..%%..%%..%%......%%..%%..........%%...%%..%%..%%....%%....%%......%%..%%..%%..%%...%%%%.."
Write-Host "..%%%%...%%..%%..%%..%%..%%..%%..%%%%%%..%%%%%...........%%...%%..%%..%%..%%%%%%..%%%%%%..%%%%%....%%%%...%%..%%."
Write-Host "................................................................................................................."
Start-Sleep -Milliseconds 200

#Set Execution Policy, User needs to accept prompt for the Session to work.
Write-Host "When prompted, type A at the next prompt, to change your Execution Policy if necessary."
Start-Sleep -Milliseconds 100

#Set Execution Policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
cls

if (!(Get-Module -ListAvailable -Name "ExchangeOnlineShell")) { 

Write-Host "................................................................................................................."
Write-Host "..%%%%...%%..%%...%%%%...%%%%%...%%%%%%..%%%%%...........%%...%%...%%%%...%%%%%%..%%......%%%%%....%%%%...%%..%%."
Write-Host ".%%......%%..%%..%%..%%..%%..%%..%%......%%..%%..........%%%.%%%..%%..%%....%%....%%......%%..%%..%%..%%...%%%%.."
Write-Host "..%%%%...%%%%%%..%%%%%%..%%%%%...%%%%....%%..%%..........%%.%.%%..%%%%%%....%%....%%......%%%%%...%%..%%....%%..."
Write-Host ".....%%..%%..%%..%%..%%..%%..%%..%%......%%..%%..........%%...%%..%%..%%....%%....%%......%%..%%..%%..%%...%%%%.."
Write-Host "..%%%%...%%..%%..%%..%%..%%..%%..%%%%%%..%%%%%...........%%...%%..%%..%%..%%%%%%..%%%%%%..%%%%%....%%%%...%%..%%."
Write-Host "................................................................................................................."
Write-Host " "
Write-Host "You may now be prompted to trust the PSGallery repo to install the Exchange Online Management modules. If prompted please Type A at the next couple prompts!"
Start-Sleep -Milliseconds 10
Write-Host "You may now be prompted to trust the PSGallery repo to install the Exchange Online Management modules. If prompted please Type A at the next couple prompts!"
Start-Sleep -Milliseconds 10
Write-Host "You may now be prompted to trust the PSGallery repo to install the Exchange Online Management modules. If prompted please Type A at the next couple prompts!"
Start-Sleep -Milliseconds 50
Write-Host " "
Write-Host " "
Write-Host "You will not need to trust the repo and install the modules again once done."
Start-Sleep -Milliseconds 10

#Install New Exchange Online Powershell Module
Install-Module -Name ExchangeOnlineShell
cls

}

Write-Host "................................................................................................................."
Write-Host "..%%%%...%%..%%...%%%%...%%%%%...%%%%%%..%%%%%...........%%...%%...%%%%...%%%%%%..%%......%%%%%....%%%%...%%..%%."
Write-Host ".%%......%%..%%..%%..%%..%%..%%..%%......%%..%%..........%%%.%%%..%%..%%....%%....%%......%%..%%..%%..%%...%%%%.."
Write-Host "..%%%%...%%%%%%..%%%%%%..%%%%%...%%%%....%%..%%..........%%.%.%%..%%%%%%....%%....%%......%%%%%...%%..%%....%%..."
Write-Host ".....%%..%%..%%..%%..%%..%%..%%..%%......%%..%%..........%%...%%..%%..%%....%%....%%......%%..%%..%%..%%...%%%%.."
Write-Host "..%%%%...%%..%%..%%..%%..%%..%%..%%%%%%..%%%%%...........%%...%%..%%..%%..%%%%%%..%%%%%%..%%%%%....%%%%...%%..%%."
Write-Host "................................................................................................................."
Write-Host " "
Write-Host "Microsoft Login Prompt should now be open. Please enter Microsoft 365 Tenant Admin Details!"

#Use Exchange Online Shell to connect to 365 - NOTE: this should also work with MFA'd accounts and such where necessary. 
Connect-ExchangeOnlineShell

#Set Loop Variable
$LoopVariable = 'True'

#Start Mailbox to Shared Question Loop
while ( $LoopVariable -eq 'True') { 

#Prompt for Mailbox or to Exit
cls
Write-Host "................................................................................................................."
Write-Host "..%%%%...%%..%%...%%%%...%%%%%...%%%%%%..%%%%%...........%%...%%...%%%%...%%%%%%..%%......%%%%%....%%%%...%%..%%."
Write-Host ".%%......%%..%%..%%..%%..%%..%%..%%......%%..%%..........%%%.%%%..%%..%%....%%....%%......%%..%%..%%..%%...%%%%.."
Write-Host "..%%%%...%%%%%%..%%%%%%..%%%%%...%%%%....%%..%%..........%%.%.%%..%%%%%%....%%....%%......%%%%%...%%..%%....%%..."
Write-Host ".....%%..%%..%%..%%..%%..%%..%%..%%......%%..%%..........%%...%%..%%..%%....%%....%%......%%..%%..%%..%%...%%%%.."
Write-Host "..%%%%...%%..%%..%%..%%..%%..%%..%%%%%%..%%%%%...........%%...%%..%%..%%..%%%%%%..%%%%%%..%%%%%....%%%%...%%..%%."
Write-Host "................................................................................................................."
Write-Host " "
Write-Host " "
$mailboxtoshared = Read-Host -Prompt 'Type the mailbox to convert or type quit'

#Allow user to quit
if ($mailboxtoshared -eq 'quit' -or $mailboxtoshared -eq 'Quit') {

 Exit
 Throw 'User Quit'

}

#Covert Mailbox if user does not want to quit
else {
Write-Host "'$mailboxtoshared' will be converted into a shared mailbox."
Set-Mailbox $mailboxtoshared -Type Shared

}

}
