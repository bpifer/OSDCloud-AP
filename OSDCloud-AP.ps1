#region Initialize
Start-Transcript -Path X:\OSDCloud\OSDBuild.log -ErrorAction Ignore
Write-Host -ForegroundColor DarkGray "Start USW OSDCloud Build"
Write-Host "System drive = $env:SystemDrive"
#endregion

#region WinPE
if ($env:SystemDrive -eq 'X:\') {
    osdcloud-StartWinPE -OSDCloud -KeyVault
    #Write-Host -ForegroundColor Cyan "To start a new PowerShell session, type 'start powershell' and press enter"
    #Write-Host -ForegroundColor Cyan "Start-OSDCloud or Start-OSDCloudGUI can be run in the new PowerShell session"
    $null = Stop-Transcript
    StartOSDCloud -OSVersion 'Windows 11' -OSBuild 24H2 -OSEdition Enterprise -OSActivation Volume -ZTI -Restart -SkipAutopilot
}
#endregion

#region OOBE
if ($env:UserName -eq 'defaultuser0') {
    osdcloud-StartOOBE -Display -Language -DateTime -Autopilot -KeyVault
    $null = Stop-Transcript

        $AutopilotRegisterCommand = 'Get-WindowsAutopilotInfo -Online -GroupTag Enterprise -Assign'
        $AutopilotRegisterProcess = osdcloud-AutopilotRegisterCommand -Command $AutopilotRegisterCommand; Start-Sleep -Seconds 30

    #RemoveAppx -Basic
    #Rsat -Basic
    #NetFX
    #UpdateDrivers
    #UpdateWindows
    #osdcloud-UpdateDefender

    if ($AutopilotRegisterProcess) {
        Write-Host -ForegroundColor Cyan 'Waiting for Autopilot Registration to complete'
        #$AutopilotRegisterProcess.WaitForExit()
        if (Get-Process -Id $AutopilotRegisterProcess.Id -ErrorAction Ignore) {
            Wait-Process -Id $AutopilotRegisterProcess.Id
        }
    }

    osdcloud-RestartComputer
}
#endregion

#region FullOS
#endregion
