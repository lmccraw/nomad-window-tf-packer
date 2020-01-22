$NomadVersion= '0.10.2'
$NomadURL= 'https://releases.hashicorp.com/nomad/' + $NomadVersion +'/nomad_'+ $NomadVersion +'_windows_amd64.zip'
$NomadOutput = 'C:\nomad_'+ $NomadVersion +'.zip'

$dir = "C:\nomad"
if(!(Test-Path -Path $dir )){
    New-Item -ItemType directory -Path $dir
    Write-Host "New folder created"
}
else
{
  Write-Host "Folder already exists"
}

Write-Host "Nomad Version: " $NomadVersion
Write-Host "NomadURL: " $NomadURL

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 
Invoke-WebRequest -Uri $NomadURL -OutFile $NomadOutput -UseDefaultCredentials

Expand-Archive -LiteralPath $NomadOutput -DestinationPath C:\nomad

Copy-Item -Path "C:\server.hcl" -Destination "C:\nomad\server.hcl"
Copy-Item -Path "C:\client.hcl" -Destination "C:\nomad\client.hcl"

sc.exe create "Nomad-Server" binPath="C:\nomad\nomad.exe agent -config=C:\nomad\server.hcl" start=auto

sc.exe start "Nomad-Server"

sc.exe create "Nomad-Client" binPath="C:\nomad\nomad.exe agent -config=C:\nomad\client.hcl" start=auto

sc.exe start "Nomad-Client"

New-Alias nomad C:\nomad\nomad.exe