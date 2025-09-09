#region Initialize
Start-Transcript -Path X:\OSDCloud\OSDBuild.log -ErrorAction Ignore
Write-Host -ForegroundColor DarkGray "Start USW OSDCloud Build"
Write-Host "System drive = $env:SystemDrive"

#Make sure I have the latest OSD Content
Write-Host  -ForegroundColor Cyan "Updating the awesome OSD PowerShell Module"
Install-Module OSD -Force -ErrorAction SilentlyContinue

Write-Host  -ForegroundColor Cyan "Importing the sweet OSD PowerShell Module"
Import-Module OSD -Force -ErrorAction SilentlyContinue
#Start-Sleep -Seconds 5

#endregion

#region WinPE
if ($env:SystemDrive -eq 'X:') {
    #Write-Host -ForegroundColor Cyan "To start a new PowerShell session, type 'start powershell' and press enter"
    Write-Host -ForegroundColor Cyan "Starting OSDCloud install"

    Start-OSDCloud -OSVersion 'Windows 11' -OSBuild 24H2 -OSEdition Enterprise -OSActivation Volume -ZTI
    
}

#endregion

