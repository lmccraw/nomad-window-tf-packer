Install-Module PSWindowsUpdate -Force
#Retrieve all Windows updates from the local computer, and save the output as a variable. 
$updates = Get-WindowsUpdate 
  
#View all properties of the first returned update. 
$updates[0] 
  
#View the titles of all returned updates. 
$updates.Title  
  
Get-WindowsUpdate -Install -AcceptAll -IgnoreReboot
