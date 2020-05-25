# Most of this came from https://github.com/microsoft/windows-dev-box-setup-scripts

#--- Configuring Windows properties ---
#--- Windows Features ---
# Show hidden files, Show protected OS files, Show file extensions
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions

#--- File Explorer Settings ---
# will expand explorer to the actual folder you're in
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
#adds things back in your left pane like recycle bin
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
#opens PC to This PC, not quick access
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
#taskbar where window is open for multi-monitor
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

#--- Uninstall unnecessary applications that come with Windows out of the box ---
Write-Host "Uninstall some applications that come with Windows out of the box" -ForegroundColor "Yellow"

# Referenced to build script
# https://docs.microsoft.com/en-us/windows/application-management/remove-provisioned-apps-during-update
# https://github.com/jayharris/dotfiles-windows/blob/master/windows.ps1#L157
# https://gist.github.com/jessfraz/7c319b046daa101a4aaef937a20ff41f
# https://gist.github.com/alirobe/7f3b34ad89a159e6daa1
# https://github.com/W4RH4WK/Debloat-Windows-10/blob/master/scripts/remove-default-apps.ps1

function removeApp {
  Param ([string]$appName)
  Write-Output "Trying to remove $appName"
  Get-AppxPackage $appName -AllUsers | Remove-AppxPackage
  Get-AppXProvisionedPackage -Online | Where DisplayName -like $appName | Remove-AppxProvisionedPackage -Online
}

$applicationList = @(
  "Microsoft.BingFinance"
  "Microsoft.3DBuilder"
  "Microsoft.BingFinance"
  "Microsoft.BingNews"
  "Microsoft.BingSports"
  "Microsoft.BingWeather"
  "Microsoft.CommsPhone"
  "Microsoft.Getstarted"
  "Microsoft.WindowsMaps"
  "*MarchofEmpires*"
  "Microsoft.GetHelp"
  "Microsoft.Messaging"
  "*Minecraft*"
  "Microsoft.MicrosoftOfficeHub"
  "Microsoft.OneConnect"
  "Microsoft.WindowsPhone"
  "Microsoft.WindowsSoundRecorder"
  "Microsoft.MicrosoftStickyNotes"
  "Microsoft.Office.Sway"
  "Microsoft.XboxApp"
  "Microsoft.XboxIdentityProvider"
  "Microsoft.ZuneMusic"
  "Microsoft.ZuneVideo"
  "Microsoft.NetworkSpeedTest"
  "Microsoft.FreshPaint"
  "Microsoft.Print3D"
  "*Autodesk*"
  "*BubbleWitch*"
  "king.com*"
  "G5*"
  "*Dell*"
  "*Facebook*"
  "*Keeper*"
  "*Netflix*"
  "*Twitter*"
  "*Plex*"
  "*.Duolingo-LearnLanguagesforFree"
  "*.EclipseManager"
  "ActiproSoftwareLLC.562882FEEB491" # Code Writer
  "*.AdobePhotoshopExpress"
);

foreach ($app in $applicationList) {
  removeApp $app
}
