Start-Transcript -Path X:\OSDCloud\OSDBuild.log -ErrorAction Ignore
Write-Host -ForegroundColor DarkGray "Start OSDCloud Build"
Write-Host "System drive = $env:SystemDrive"

if ($env:SystemDrive -eq 'X:') {
    #Write-Host -ForegroundColor Cyan "To start a new PowerShell session, type 'start powershell' and press enter"
    Write-Host -ForegroundColor Cyan "Starting OSDCloud install"

    Start-OSDCloud -OSVersion 'Windows 11' -OSBuild 24H2 -OSEdition Enterprise -OSActivation Volume -ZTI -Restart
}
