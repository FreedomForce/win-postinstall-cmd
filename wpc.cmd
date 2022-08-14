title win-postinstall-cmd
@echo off
cd /d %~dp0
set breakline=--------------------------------------------------
set "print=echo. & echo"
:MENU
cls
%print% SELECT YOUR TASK:
%print% [1] CHECK IF WINGET IS INSTALLED AND CHECK FOR UPDATES
echo [2] DISABLE HIBERNATE AND DISABLE PASSWORD EXPIRATION
echo [3] IMPORT SETTINGS
echo [4] INSTALL APPLICATIONS
echo [5] DELETE CREATED FILES
REM
set "number=Error"
echo. & set /p number=ENTER THE NUMBER: 
IF %number%==1 GOTO UPDATE
IF %number%==2 GOTO HIBERNATEandPASSWORD
IF %number%==3 GOTO REGISTRY
IF %number%==4 GOTO WINGET
IF %number%==5 GOTO DELETE
GOTO MENU
REM                     FIRST CHAPTER | UPDATES AND USER SETTINGS
:UPDATE
echo %breakline% & %print%          CHECK IF WINGET IS INSTALLED
powershell Start ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1
%print%         CHECK FOR UPDATES
powershell Start ms-settings:windowsupdate-action
GOTO MENU
:HIBERNATEandPASSWORD
echo %breakline% & %print%          DISABLE HIBERNATE
echo. & powercfg /h off && powercfg /a |more
echo %breakline% & %print%          DISABLE PASSWORD EXPIRATION
echo. & wmic UserAccount where "Name='%username%'" set PasswordExpires=False
pause
GOTO MENU
REM                     SECOND CHAPTER | REGISTRY KEYS
:REGISTRY
echo %breakline% & %print%          CREATING REGISTRY FILE
del settings.reg 2>NUL & echo DELETING EXISTING SETTINGS.REG FILE AND CREATING A NEW ONE
REM
echo Windows Registry Editor Version 5.00>> settings.reg
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
echo.>> settings.reg
echo ; Remove Widgets from the Taskbar>> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> settings.reg
echo "TaskbarDa"=dword:00000000>> settings.reg
echo.>> settings.reg
echo ; START MENU>> settings.reg
echo ; Always hide most used list in start menu>> settings.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer]>> settings.reg
echo "ShowOrHideMostUsedApps"=dword:00000002>> settings.reg
echo [HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer]>> settings.reg
echo "ShowOrHideMostUsedApps"=->> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]>> settings.reg
echo "NoStartMenuMFUprogramsList"=->> settings.reg
echo "NoInstrumentation"=->> settings.reg
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
echo ; EXPLORER>> settings.reg
echo ; Disable Compact Mode>> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> settings.reg
echo "UseCompactMode"=dword:00000001>> settings.reg
echo.>> settings.reg
echo ; Open file explorer to this pc>> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> settings.reg
echo "LaunchTo"=dword:00000001>> settings.reg
echo.>> settings.reg
echo ; Show file name extensions>> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> settings.reg
echo "HideFileExt"=dword:00000000>> settings.reg
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
echo ; MOUSE>> settings.reg
echo ; Turn off enhance pointer precision>> settings.reg
echo [HKEY_CURRENT_USER\Control Panel\Mouse]>> settings.reg
echo "MouseSpeed"="0">> settings.reg
echo "MouseThreshold1"="0">> settings.reg
echo "MouseThreshold2"="0">> settings.reg
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
echo ; Disable "Suggest ways to get the most out of Windows and finish setting up this device">> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement]>> settings.reg
echo "ScoobeSystemSettingEnabled"=dword:00000000>> settings.reg
echo.>> settings.reg
echo ; Disable "Windows Experience ...">> settings.reg
echo [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]>> settings.reg
echo "SubscribedContent-310093Enabled"=dword:00000000>> settings.reg
echo.>> settings.reg
echo ; Disable "Get tips and suggestions when using Windows">> settings.reg
echo [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]>> settings.reg
echo "SubscribedContent-338389Enabled"=dword:00000000>> settings.reg
echo.>> settings.reg
echo ; Enable NumLock by default>> settings.reg
echo [HKEY_USERS\.DEFAULT\Control Panel\Keyboard]>> settings.reg
echo "InitialKeyboardIndicators"="2147483650">> settings.reg
echo.>> settings.reg
echo ; Disable ease of access settings>> settings.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Ease of Access]>> settings.reg
echo "selfvoice"=dword:00000000>> settings.reg
echo "selfscan"=dword:00000000>> settings.reg
echo [HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys]>> settings.reg
echo "Flags"="2">> settings.reg
echo [HKEY_CURRENT_USER\Control Panel\Accessibility\ToggleKeys]>> settings.reg
echo "Flags"="34">> settings.reg
REM
echo FILE CREATED
pause
echo %breakline% & %print%          IMPORTING REGISTRY KEYS
regedit /s "settings.reg" & echo IMPORTED
pause
GOTO MENU
REM                     THIRD CHAPTER | WINGET
:WINGET
del winget.json 2>NUL & del selected-apps.txt 2>NUL
GOTO StartOfTheWingetFile
:WINGETMenu
cls
%print% SELECT WHAT TO INSTALL:
%print% [1] C++ Redistributables        [2] 7zip
echo [3] Firefox                     [4] Chrome
echo [5] Notepad++                   [6] Discord
echo [7] Parsec                      [8] Steam
echo [9] Epic Games Launcher         [10] Ubisoft Connect
echo [11] Microsoft Teams            [12] OBS Studio
echo [13] Zero Tier One              [14] qBittorrent
echo [15] Sandboxie Plus             [16] Viber
echo [17] Java                       [18] PowerToys
echo [19] KeePass                    [20] Malwarebytes
echo [21] Zoom                       [22] VLC
echo [23] Cloudflare Warp
echo %breakline% & %print% [*] CREATE FILE & echo [0] GO BACK
if exist selected-apps.txt echo [/] CLEAR LIST OF SELECTED APPS & echo %breakline% & %print% SELECTED APPS: & type selected-apps.txt 2>NUL
REM
set "symbol=Error"
echo. & set /p "symbol=ENTER THE SYMBOL: "
IF %symbol%==1 GOTO C++Redist
IF %symbol%==2 GOTO 7zip
IF %symbol%==3 GOTO Firefox
IF %symbol%==4 GOTO Chrome
IF %symbol%==5 GOTO Notepad++
IF %symbol%==6 GOTO Discord
IF %symbol%==7 GOTO Parsec
IF %symbol%==8 GOTO Steam
IF %symbol%==9 GOTO EpicGamesLauncher
IF %symbol%==10 GOTO Ubisoft
IF %symbol%==11 GOTO MicrosoftTeams
IF %symbol%==12 GOTO OBSStudio
IF %symbol%==13 GOTO ZeroTierOne
IF %symbol%==14 GOTO qBittorrent
IF %symbol%==15 GOTO SandboxiePlus
IF %symbol%==16 GOTO Viber
IF %symbol%==17 GOTO Java
IF %symbol%==18 GOTO PowerToys
IF %symbol%==19 GOTO KeePass
IF %symbol%==20 GOTO Malwarebytes
IF %symbol%==21 GOTO Zoom
IF %symbol%==22 GOTO VLC
IF %symbol%==23 GOTO CloudflareWarp
IF %symbol%==* GOTO EndOfTheWingetFile
IF %symbol%==0 GOTO MENU
IF %symbol%==/ GOTO WINGET
GOTO WINGETMenu
:StartOfTheWingetFile
echo {>> winget.json
echo    "$schema" : "https://aka.ms/winget-packages.schema.2.0.json",>> winget.json
echo    "CreationDate" : "2022-08",>> winget.json
echo    "Sources" : >> winget.json
echo    [>> winget.json
echo        {>> winget.json
echo            "Packages" : >> winget.json
echo            [>> winget.json
GOTO WINGETMenu
:C++Redist
find /c "C++ Redistributable added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Microsoft.VC++2015-2022Redist-x64">> winget.json
echo                },>> winget.json
echo                {>> winget.json
echo                    "PackageIdentifier" : "Microsoft.VC++2015-2019Redist-x86">> winget.json
echo                },>> winget.json
echo                {>> winget.json
echo                    "PackageIdentifier" : "Microsoft.VC++2015-2019Redist-x64">> winget.json
echo                },>> winget.json
echo                {>> winget.json
echo                    "PackageIdentifier" : "Microsoft.VC++2013Redist-x86">> winget.json
echo                },>> winget.json
echo                {>> winget.json
echo                    "PackageIdentifier" : "Microsoft.VC++2013Redist-x64">> winget.json
echo                },>> winget.json
echo                {>> winget.json
echo                    "PackageIdentifier" : "Microsoft.VC++2012Redist-x86">> winget.json
echo                },>> winget.json
echo                {>> winget.json
echo                    "PackageIdentifier" : "Microsoft.VC++2012Redist-x64">> winget.json
echo                },>> winget.json
echo                {>> winget.json
echo                    "PackageIdentifier" : "Microsoft.VC++2010Redist-x86">> winget.json
echo                },>> winget.json
echo                {>> winget.json
echo                    "PackageIdentifier" : "Microsoft.VC++2008Redist-x86">> winget.json
echo                },>> winget.json
echo                {>> winget.json
echo                    "PackageIdentifier" : "Microsoft.VC++2008Redist-x64">> winget.json
echo                },>> winget.json
echo                {>> winget.json
echo                    "PackageIdentifier" : "Microsoft.VC++2005Redist-x86">> winget.json
echo                },>> winget.json
echo                {>> winget.json
echo                    "PackageIdentifier" : "Microsoft.VC++2005Redist-x64">> winget.json
echo                },>> winget.json
echo C++ Redistributable added>> selected-apps.txt
GOTO WINGETMenu
:7zip
find /c "7zip added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "7zip.7zip">> winget.json
echo                },>> winget.json
echo 7zip added>> selected-apps.txt
GOTO WINGETMenu
:Firefox
find /c "Firefox added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Mozilla.Firefox.ESR">> winget.json
echo                },>> winget.json
echo Firefox added>> selected-apps.txt
GOTO WINGETMenu
:Chrome
find /c "Chrome added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Google.Chrome">> winget.json
echo                },>> winget.json
echo Chrome added>> selected-apps.txt
GOTO WINGETMenu
:Notepad++
find /c "Notepad++ added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Notepad++.Notepad++">> winget.json
echo                },>> winget.json
echo Notepad++ added>> selected-apps.txt
GOTO WINGETMenu
:Discord
find /c "Discord added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Discord.Discord">> winget.json
echo                },>> winget.json
echo Discord added>> selected-apps.txt
GOTO WINGETMenu
:Parsec
find /c "Parsec added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Parsec.Parsec">> winget.json
echo                },>> winget.json
echo Parsec added>> selected-apps.txt
GOTO WINGETMenu
:Steam
find /c "Steam added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Valve.Steam">> winget.json
echo                },>> winget.json
echo Steam added>> selected-apps.txt
GOTO WINGETMenu
:EpicGamesLauncher
find /c "Epic Games Launcher added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "EpicGames.EpicGamesLauncher">> winget.json
echo                },>> winget.json
echo Epic Games Launcher added>> selected-apps.txt
GOTO WINGETMenu
:Ubisoft
find /c "Ubisoft Connect added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Ubisoft.Connect">> winget.json
echo                },>> winget.json
echo Ubisoft Connect added>> selected-apps.txt
GOTO WINGETMenu
:MicrosoftTeams
find /c "Microsoft Teams added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Microsoft.Teams">> winget.json
echo                },>> winget.json
echo Microsoft Teams added>> selected-apps.txt
GOTO WINGETMenu
:OBSStudio
find /c "OBS Studio added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "OBSProject.OBSStudio">> winget.json
echo                },>> winget.json
echo OBS Studio added>> selected-apps.txt
GOTO WINGETMenu
:ZeroTierOne
find /c "Zero Tier One added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "ZeroTier.ZeroTierOne">> winget.json
echo                },>> winget.json
echo Zero Tier One added>> selected-apps.txt
GOTO WINGETMenu
:qBittorrent
find /c "qBittorrent added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "qBittorrent.qBittorrent">> winget.json
echo                },>> winget.json
echo qBittorrent added>> selected-apps.txt
GOTO WINGETMenu
:SandboxiePlus
find /c "Sandboxie Plus added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Sandboxie.Plus">> winget.json
echo                },>> winget.json
echo Sandboxie Plus added>> selected-apps.txt
GOTO WINGETMenu
:Viber
find /c "Viber added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Viber.Viber">> winget.json
echo                },>> winget.json
echo Viber added>> selected-apps.txt
GOTO WINGETMenu
:Java
find /c "Java added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Oracle.JavaRuntimeEnvironment">> winget.json
echo                },>> winget.json
echo Java added>> selected-apps.txt
GOTO WINGETMenu
:PowerToys
find /c "PowerToys added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Microsoft.PowerToys">> winget.json
echo                },>> winget.json
echo PowerToys added>> selected-apps.txt
GOTO WINGETMenu
:KeePass
find /c "KeePass added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "DominikReichl.KeePass">> winget.json
echo                },>> winget.json
echo KeePass added>> selected-apps.txt
GOTO WINGETMenu
:Malwarebytes
find /c "Malwarebytes added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Malwarebytes.Malwarebytes">> winget.json
echo                },>> winget.json
echo Malwarebytes added>> selected-apps.txt
GOTO WINGETMenu
:Zoom
find /c "Zoom added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Zoom.Zoom">> winget.json
echo                },>> winget.json
echo Zoom added>> selected-apps.txt
GOTO WINGETMenu
:VLC
find /c "VLC added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "VideoLAN.VLC">> winget.json
echo                },>> winget.json
echo VLC added>> selected-apps.txt
GOTO WINGETMenu
:CloudflareWarp
find /c "Cloudflare Warp added" selected-apps.txt >NUL && GOTO WINGETMenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Cloudflare.Warp">> winget.json
echo                }>> winget.json
echo Cloudflare Warp added>> selected-apps.txt
GOTO WINGETMenu
:EndOfTheWingetFile
echo            ],>> winget.json
echo            "SourceDetails" : >> winget.json
echo            {>> winget.json
echo                "Argument" : "https://winget.azureedge.net/cache",>> winget.json
echo                "Identifier" : "Microsoft.Winget.Source_8wekyb3d8bbwe",>> winget.json
echo                "Name" : "winget",>> winget.json
echo                "Type" : "Microsoft.PreIndexed.Package">> winget.json
echo            }>> winget.json
echo        }>> winget.json
echo    ]>> winget.json
echo }>> winget.json
REM
echo %breakline% & %print% FILE CREATED
pause
echo %breakline% & %print%          WINGET.JSON INITIALIZATION
winget import -i .\winget.json --accept-source-agreements --accept-package-agreements
pause
GOTO MENU
REM                     FOURTH CHAPTER | CLEANUP
:DELETE
del winget.json 2>NUL & del settings.reg 2>NUL & del selected-apps.txt 2>NUL & rmdir /s /q %Temp%\WinGet\ 2>NUL
echo %breakline% & %print%          CREATED FILES DELETED
pause
GOTO MENU
