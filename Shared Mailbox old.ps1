#Set Execution Policy, User needs to accept prompt for the Session to work.
Write-Host "If prompted, please press A at the next prompt!"
Start-Sleep -Milliseconds 100

#Set Execution Policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force

#Get Credentials from User
$UserCredential = Get-Credential

#Create and Import New Powershell Session from 365
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $usercredential -Authentication Basic -AllowRedirection
Import-PSSession $Session

#Set Loop Variable
$LoopVariable = 'True'

#Start Mailbox to Shared Question Loop
while ( $LoopVariable -eq 'True') { 

#Prompt for Mailbox or to Exit
Clear-Host
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
