@echo off
cd /d %~dp0
::						FIRST CHAPTER | UPDATES AND USER SETTINGS
powershell write-host "CHECK IF WINGET IS INSTALLED" -fore Yellow -back Blue
powershell Start ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1
::
powershell write-host "CHECK FOR UPDATES" -fore Yellow -back Blue
powershell Start ms-settings:windowsupdate-action
::
pause
::
powershell write-host DISABLE HIBERNATE -fore Yellow -back Blue
::
powercfg /h off && powercfg /a |more
::
pause
::
powershell write-host DISABLE PASSWORD EXPIRATION -fore Yellow -back Blue
::
wmic UserAccount where Name='Workstation' set PasswordExpires=False
::
pause
::
::						SECOND CHAPTER | REGISTRY KEYS
powershell write-host CREATING REGISTRY FILE -fore Yellow -back Blue
powershell write-host DELETING EXISTING SETTINGS.REG FILE AND CREATING A NEW ONE -fore Green
::
del settings.reg 2>NUL
::
echo Windows Registry Editor Version 5.00>> settings.reg
echo.>> settings.reg
echo.>> settings.reg
echo.>> settings.reg
echo.>> settings.reg
echo ; TASKBAR>> settings.reg
echo ; Remove chat from taskbar>> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> settings.reg
echo "TaskbarMn"=dword:00000000>> settings.reg
echo.>> settings.reg
echo ; Remove Cortana from taskbar>> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> settings.reg
echo "ShowCortanaButton"=dword:00000000>> settings.reg
echo.>> settings.reg
echo ; Remove task view from taskbar>> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> settings.reg
echo "ShowTaskViewButton"=dword:00000000>> settings.reg
echo.>> settings.reg
echo ; Remove search from taskbar>> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search]>> settings.reg
echo "SearchboxTaskbarMode"=dword:00000000>> settings.reg
echo.>> settings.reg
echo ; Remove meet now>> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]>> settings.reg
echo "HideSCAMeetNow"=dword:00000001>> settings.reg
echo.>> settings.reg
echo ; Remove news and interests>> settings.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds]>> settings.reg
echo "EnableFeeds"=dword:00000000>> settings.reg
echo.>> settings.reg
echo ; Remove taskbar pins>> settings.reg
echo [-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband]>> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband\AuxilliaryPins]>> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> settings.reg
echo "TaskbarDa"=dword:00000000>> settings.reg
echo.>> settings.reg
echo.>> settings.reg
echo.>> settings.reg
echo.>> settings.reg
echo ; START MENU>> settings.reg
echo ; Always hide most used list in start menu>> settings.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer]>> settings.reg
echo "ShowOrHideMostUsedApps"=dword:00000002>> settings.reg
echo.>> settings.reg
echo [HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer]>> settings.reg
echo "ShowOrHideMostUsedApps"=->> settings.reg
echo.>> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]>> settings.reg
echo "NoStartMenuMFUprogramsList"=->> settings.reg
echo "NoInstrumentation"=->> settings.reg
echo.>> settings.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]>> settings.reg
echo "NoStartMenuMFUprogramsList"=->> settings.reg
echo "NoInstrumentation"=->> settings.reg
echo.>> settings.reg
echo ; Disable show recently added apps>> settings.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer]>> settings.reg
echo "HideRecentlyAddedApps"=dword:00000001>> settings.reg
echo.>> settings.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]>> settings.reg
echo "HideRecentlyAddedApps"=dword:00000001>> settings.reg
echo.>> settings.reg
echo ; Disable show recently opened items in start, jump lists and file explorer>> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> settings.reg
echo "Start_TrackDocs"=dword:00000000>> settings.reg
echo.>> settings.reg
echo.>> settings.reg
echo.>> settings.reg
echo.>> settings.reg
echo ; EXPLORER>> settings.reg
echo ; Open file explorer to this pc>> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> settings.reg
echo "LaunchTo"=dword:00000001>> settings.reg
echo.>> settings.reg
echo ; Show file name extensions>> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> settings.reg
echo "HideFileExt"=dword:00000000>> settings.reg
echo.>> settings.reg
echo.>> settings.reg
echo.>> settings.reg
echo.>> settings.reg
echo ; SOUND>> settings.reg
echo ; Sound communications do nothing>> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Multimedia\Audio]>> settings.reg
echo "UserDuckingPreference"=dword:00000003>> settings.reg
echo.>> settings.reg
echo ; Disable startup sound>> settings.reg
echo [HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation]>> settings.reg
echo "DisableStartupSound"=dword:00000001>> settings.reg
echo.>> settings.reg
echo.>> settings.reg
echo.>> settings.reg
echo.>> settings.reg
echo ; MOUSE>> settings.reg
echo ; Turn off enhance pointer precision>> settings.reg
echo [HKEY_CURRENT_USER\Control Panel\Mouse]>> settings.reg
echo "MouseSpeed"="0">> settings.reg
echo "MouseThreshold1"="0">> settings.reg
echo "MouseThreshold2"="0">> settings.reg
echo.>> settings.reg
echo.>> settings.reg
echo.>> settings.reg
echo.>> settings.reg
echo ; OTHER>> settings.reg
echo ; Disable automatic maintenance>> settings.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance]>> settings.reg
echo "MaintenanceDisabled"=dword:00000001>> settings.reg
echo.>> settings.reg
echo ; Disable use my sign in info after restart>> settings.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]>> settings.reg
echo "DisableAutomaticRestartSignOn"=dword:00000001>> settings.reg
echo.>> settings.reg
echo ; Alt tab open windows only>> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> settings.reg
echo "MultiTaskingAltTabFilter"=dword:00000003>> settings.reg
echo.>> settings.reg
echo ; Restore the classic context menu 4 w11>> settings.reg
echo [HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32]>> settings.reg
echo @="">> settings.reg
echo.>> settings.reg
echo ;Disable "Suggest ways to get the most out of Windows and finish setting up this device">> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement]>> settings.reg
echo "ScoobeSystemSettingEnabled"=dword:00000000>> settings.reg
echo.>> settings.reg
echo ;Disable "Windows Experience ...">> settings.reg
echo [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]>> settings.reg
echo "SubscribedContent-310093Enabled"=dword:00000000>> settings.reg
echo.>> settings.reg
echo ;Disable "Get tips and suggestions when using Windows">> settings.reg
echo [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]>> settings.reg
echo "SubscribedContent-338389Enabled"=dword:00000000>> settings.reg
echo.>> settings.reg
echo ;Disable Compact Mode>> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> settings.reg
echo "UseCompactMode"=dword:00000001>> settings.reg
echo.>> settings.reg
echo ;Enable NumLock by default>> settings.reg
echo [HKEY_USERS\.DEFAULT\Control Panel\Keyboard]>> settings.reg
echo "InitialKeyboardIndicators"="2147483650">> settings.reg
echo.>> settings.reg
echo ; Disable ease of access settings>> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Ease of Access]>> settings.reg
echo "selfvoice"=dword:00000000>> settings.reg
echo "selfscan"=dword:00000000>> settings.reg
echo.>> settings.reg
echo [HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys]>> settings.reg
echo "Flags"="2">> settings.reg
echo.>> settings.reg
echo [HKEY_CURRENT_USER\Control Panel\Accessibility\ToggleKeys]>> settings.reg
echo "Flags"="34">> settings.reg
::
powershell write-host FILE CREATED -fore Black -back White
::
pause
::
powershell write-host IMPORTING REGISTRY KEYS -fore Yellow -back Blue
::
settings.reg && powershell write-host OK -fore Black -back White
::
pause
::
::						THIRD CHAPTER | WINGET
powershell write-host CREATING WINGET FILE -fore Yellow -back Blue
powershell write-host DELETING EXISTING WINGET.JSON FILE AND CREATING A NEW ONE -fore Green
::
del winget.json 2>NUL
::
echo {>> winget.json
echo 	"$schema" : "https://aka.ms/winget-packages.schema.2.0.json",>> winget.json
echo 	"CreationDate" : "2022-07",>> winget.json
echo 	"Sources" : >> winget.json
echo 	[>> winget.json
echo 		{>> winget.json
echo 			"Packages" : >> winget.json
echo 			[>> winget.json
echo 				{>> winget.json
echo 					"PackageIdentifier" : "7zip.7zip">> winget.json
echo 				},>> winget.json
echo 				{>> winget.json
echo 					"PackageIdentifier" : "Discord.Discord">> winget.json
echo 				},>> winget.json
echo 				{>> winget.json
echo 					"PackageIdentifier" : "Parsec.Parsec">> winget.json
echo 				},>> winget.json
echo 				{>> winget.json
echo 					"PackageIdentifier" : "Mozilla.Firefox.ESR">> winget.json
echo 				},>> winget.json
echo 				{>> winget.json
echo 					"PackageIdentifier" : "Notepad++.Notepad++">> winget.json
echo 				},>> winget.json
echo 				{>> winget.json
echo 					"PackageIdentifier" : "OBSProject.OBSStudio">> winget.json
echo 				},>> winget.json
echo 				{>> winget.json
echo 					"PackageIdentifier" : "Ubisoft.Connect">> winget.json
echo 				},>> winget.json
echo 				{>> winget.json
echo 					"PackageIdentifier" : "Sandboxie.Plus">> winget.json
echo 				},>> winget.json
echo 				{>> winget.json
echo 					"PackageIdentifier" : "Valve.Steam">> winget.json
echo 				},>> winget.json
echo 				{>> winget.json
echo 					"PackageIdentifier" : "Microsoft.Teams">> winget.json
echo 				},>> winget.json
echo 				{>> winget.json
echo 					"PackageIdentifier" : "ZeroTier.ZeroTierOne">> winget.json
echo 				},>> winget.json
echo 				{>> winget.json
echo 					"PackageIdentifier" : "qBittorrent.qBittorrent">> winget.json
echo 				},>> winget.json
echo 				{>> winget.json
echo 					"PackageIdentifier" : "Google.Chrome">> winget.json
echo 				},>> winget.json
echo 				{>> winget.json
echo 					"PackageIdentifier" : "Viber.Viber">> winget.json
echo 				},>> winget.json
echo 				{>> winget.json
echo 					"PackageIdentifier" : "Oracle.JavaRuntimeEnvironment">> winget.json
echo 				},>> winget.json
echo 				{>> winget.json
echo 					"PackageIdentifier" : "Microsoft.PowerToys">> winget.json
echo 				},>> winget.json
echo 				{>> winget.json
echo 					"PackageIdentifier" : "DominikReichl.KeePass">> winget.json
echo 				},>> winget.json
echo 				{>> winget.json
echo 					"PackageIdentifier" : "Malwarebytes.Malwarebytes">> winget.json
echo 				},>> winget.json
echo 				{>> winget.json
echo 					"PackageIdentifier" : "Zoom.Zoom">> winget.json
echo 				},>> winget.json
echo 				{>> winget.json
echo 					"PackageIdentifier" : "VideoLAN.VLC">> winget.json
echo 				},>> winget.json
echo 				{>> winget.json
echo 					"PackageIdentifier" : "Cloudflare.Warp">> winget.json
echo 				},>> winget.json
echo 				{>> winget.json
echo 					"PackageIdentifier" : "EpicGames.EpicGamesLauncher">> winget.json
echo 				}>> winget.json
echo 			],>> winget.json
echo 			"SourceDetails" : >> winget.json
echo 			{>> winget.json
echo 				"Argument" : "https://winget.azureedge.net/cache",>> winget.json
echo 				"Identifier" : "Microsoft.Winget.Source_8wekyb3d8bbwe",>> winget.json
echo 				"Name" : "winget",>> winget.json
echo 				"Type" : "Microsoft.PreIndexed.Package">> winget.json
echo 			}>> winget.json
echo 		}>> winget.json
echo 	],>> winget.json
echo }>> winget.json
::
powershell write-host FILE CREATED -fore Black -back White
::
pause
::
powershell write-host WINGET.JSON INITIALIZATION -fore Yellow -back Blue
::
winget import -i .\winget.json --accept-source-agreements --accept-package-agreements
::
pause
::
::						FOURTH CHAPTER | FINAL
powershell write-host DELETING CREATED FILES AND RESTARTING THE SYSTEM -fore Yellow -back Blue
::
del winget.json 2>NUL
del settings.reg 2>NUL
::
pause
:: 
C:\Windows\System32\shutdown.exe /r /t 0
