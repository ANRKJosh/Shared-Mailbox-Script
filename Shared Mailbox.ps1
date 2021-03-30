Write-Host "................................................................................................................."
Write-Host "..%%%%...%%..%%...%%%%...%%%%%...%%%%%%..%%%%%...........%%...%%...%%%%...%%%%%%..%%......%%%%%....%%%%...%%..%%."
Write-Host ".%%......%%..%%..%%..%%..%%..%%..%%......%%..%%..........%%%.%%%..%%..%%....%%....%%......%%..%%..%%..%%...%%%%.."
Write-Host "..%%%%...%%%%%%..%%%%%%..%%%%%...%%%%....%%..%%..........%%.%.%%..%%%%%%....%%....%%......%%%%%...%%..%%....%%..."
Write-Host ".....%%..%%..%%..%%..%%..%%..%%..%%......%%..%%..........%%...%%..%%..%%....%%....%%......%%..%%..%%..%%...%%%%.."
Write-Host "..%%%%...%%..%%..%%..%%..%%..%%..%%%%%%..%%%%%...........%%...%%..%%..%%..%%%%%%..%%%%%%..%%%%%....%%%%...%%..%%."
Write-Host "................................................................................................................."
Start-Sleep -Milliseconds 200

#Set Execution Policy, User needs to accept prompt for the Session to work.
Write-Host "If prompted, please press A at the next prompt!"
Start-Sleep -Milliseconds 100

#Set Execution Policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force

Write-Host "You may now be prompted to trust the PSGallery repo to install the Exchange Online Management modules. Please Type A at the prompt"
#Install New Exchange Online Powershell Module
Install-Module -Name ExchangeOnlineShell
Install-Module -Name ExchangeOnlineManagement

#Use Exchange Online Shell to connect to 365 - NOTE: this should also work with MFA'd accounts and such where necessary. 
Connect-ExchangeOnlineShell

#Set Loop Variable
$LoopVariable = 'True'

#Start Mailbox to Shared Question Loop
while ( $LoopVariable -eq 'True') { 

#Prompt for Mailbox or to Exit
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
