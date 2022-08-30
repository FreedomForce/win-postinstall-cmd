@echo off
title win-postinstall-cmd                         
cd /d %~dp0
set breakline=------------------------------------------------------------------------------------------
set "print=echo. & echo"

:menu
cls & call :delete
%print% SELECT YOUR TASK:
%print% [1] CHECK IF WINGET IS INSTALLED AND CHECK FOR UPDATES
echo [2] DISABLE HIBERNATE AND DISABLE PASSWORD EXPIRATION
echo [3] IMPORT SETTINGS
echo [4] INSTALL APPLICATIONS

set "number=Error" & echo. & set /p number=ENTER THE NUMBER: 
if %number%==1 goto :update
if %number%==2 goto :hibernateandpassword
if %number%==3 goto :registry
if %number%==4 goto :winget
goto :menu

rem                     FIRST CHAPTER - UPDATES AND USER SETTINGS
:update
echo %breakline% & %print% CHECK IF WINGET IS INSTALLED
start ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1

%print% CHECK FOR UPDATES
start ms-settings:windowsupdate-action
goto :menu

:hibernateandpassword
echo %breakline% & %print% DISABLE HIBERNATE
echo. & powercfg /h off && powercfg /a |more

echo %breakline% & %print% DISABLE PASSWORD EXPIRATION
echo. & wmic UserAccount where "Name='%username%'" set PasswordExpires=False
pause & goto :menu

rem                     SECOND CHAPTER - REGISTRY KEYS
:registry
echo %breakline% & %print% CREATING REGISTRY FILE
   
echo Windows Registry Editor Version 5.00>> settings.reg
echo.>> settings.reg

rem          Remove chat from taskbar
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> settings.reg
echo "TaskbarMn"=dword:00000000>> settings.reg
echo.>> settings.reg

rem          Remove Cortana from taskbar
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> settings.reg
echo "ShowCortanaButton"=dword:00000000>> settings.reg
echo.>> settings.reg

rem          Remove task view from taskbar
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> settings.reg
echo "ShowTaskViewButton"=dword:00000000>> settings.reg
echo.>> settings.reg

rem          Remove search from taskbar
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search]>> settings.reg
echo "SearchboxTaskbarMode"=dword:00000000>> settings.reg
echo.>> settings.reg

rem          Remove meet now
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]>> settings.reg
echo "HideSCAMeetNow"=dword:00000001>> settings.reg
echo.>> settings.reg

rem          Remove news and interests
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds]>> settings.reg
echo "EnableFeeds"=dword:00000000>> settings.reg
echo.>> settings.reg

rem          Remove taskbar pins
echo [-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband]>> settings.reg
echo.>> settings.reg

echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband\AuxilliaryPins]>> settings.reg
echo.>> settings.reg

rem          Remove Widgets from the Taskbar
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> settings.reg
echo "TaskbarDa"=dword:00000000>> settings.reg
echo.>> settings.reg

rem          Always hide most used list in start menu
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

rem          Disable show recently added apps
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer]>> settings.reg
echo "HideRecentlyAddedApps"=dword:00000001>> settings.reg
echo.>> settings.reg

echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]>> settings.reg
echo "HideRecentlyAddedApps"=dword:00000001>> settings.reg
echo.>> settings.reg

rem          Disable show recently opened items in start, jump lists and file explorer
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> settings.reg
echo "Start_TrackDocs"=dword:00000000>> settings.reg
echo.>> settings.reg

rem          Disable Compact Mode
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> settings.reg
echo "UseCompactMode"=dword:00000001>> settings.reg
echo.>> settings.reg

rem          Open file explorer to this pc
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> settings.reg
echo "LaunchTo"=dword:00000001>> settings.reg
echo.>> settings.reg

rem          Show file name extensions
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> settings.reg
echo "HideFileExt"=dword:00000000>> settings.reg
echo.>> settings.reg

rem          Sound communications do nothing
echo [HKEY_CURRENT_USER\Software\Microsoft\Multimedia\Audio]>> settings.reg
echo "UserDuckingPreference"=dword:00000003>> settings.reg
echo.>> settings.reg

rem          Disable startup sound
echo [HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation]>> settings.reg
echo "DisableStartupSound"=dword:00000001>> settings.reg
echo.>> settings.reg

rem          Turn off enhance pointer precision
echo [HKEY_CURRENT_USER\Control Panel\Mouse]>> settings.reg
echo "MouseSpeed"="0">> settings.reg
echo "MouseThreshold1"="0">> settings.reg
echo "MouseThreshold2"="0">> settings.reg
echo.>> settings.reg

rem          Disable automatic maintenance
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance]>> settings.reg
echo "MaintenanceDisabled"=dword:00000001>> settings.reg
echo.>> settings.reg

rem          Disable use my sign in info after restart
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]>> settings.reg
echo "DisableAutomaticRestartSignOn"=dword:00000001>> settings.reg
echo.>> settings.reg

rem          Alt tab open windows only
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]>> settings.reg
echo "MultiTaskingAltTabFilter"=dword:00000003>> settings.reg
echo.>> settings.reg

rem          Restore the classic context menu 4 w11
echo [HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32]>> settings.reg
echo @="">> settings.reg
echo.>> settings.reg

rem          Disable "Suggest ways to get the most out of Windows and finish setting up this device"
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement]>> settings.reg
echo "ScoobeSystemSettingEnabled"=dword:00000000>> settings.reg
echo.>> settings.reg

rem          Disable "Windows Experience ..."
echo [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]>> settings.reg
echo "SubscribedContent-310093Enabled"=dword:00000000>> settings.reg
echo.>> settings.reg

rem          Disable "Get tips and suggestions when using Windows"
echo [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]>> settings.reg
echo "SubscribedContent-338389Enabled"=dword:00000000>> settings.reg
echo.>> settings.reg

rem          Enable NumLock by default
echo [HKEY_USERS\.DEFAULT\Control Panel\Keyboard]>> settings.reg
echo "InitialKeyboardIndicators"="2147483650">> settings.reg
echo.>> settings.reg

rem          Disable ease of access settings
echo [HKEY_CURRENT_USER\Software\Microsoft\Ease of Access]>> settings.reg
echo "selfvoice"=dword:00000000>> settings.reg
echo "selfscan"=dword:00000000>> settings.reg
echo.>> settings.reg

echo [HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys]>> settings.reg
echo "Flags"="2">> settings.reg
echo.>> settings.reg

echo [HKEY_CURRENT_USER\Control Panel\Accessibility\ToggleKeys]>> settings.reg
echo "Flags"="34">> settings.reg

echo FILE CREATED
echo %breakline% & echo. & choice /n /m "CONTINUE? [Y/N]"
if errorlevel 2 goto :menu
if errorlevel 1 goto :importregistrykeys

:importregistrykeys
echo %breakline% & %print% IMPORTING REGISTRY KEYS
regedit /s "settings.reg"
pause & goto :menu

rem                     THIRD CHAPTER - WINGET
:winget
goto :startofthewingetfile

:wingetmenu
cls
%print% SELECT WHAT TO INSTALL:
echo.
echo: [1] C++ Redistributables        [2] 7zip                        [3] Firefox
echo: [4] Chrome                      [5] Notepad++                   [6] Discord
echo: [7] Parsec                      [8] Steam                       [9] Epic Games Launcher
echo: [10] Ubisoft Connect            [11] Microsoft Teams            [12] OBS Studio
echo: [13] Zero Tier One              [14] qBittorrent                [15] Sandboxie Plus
echo: [16] Viber                      [17] Java                       [18] PowerToys
echo: [19] KeePass                    [20] Malwarebytes               [21] Zoom
echo: [22] VLC                        [23] Cloudflare Warp

echo %breakline% & %print% [*] CREATE FILE & echo [0] GO BACK
if exist selected-apps.txt echo [/] CLEAR LIST OF SELECTED APPS & echo %breakline% & %print% SELECTED APPS: & type selected-apps.txt 2>nul

set "symbol=Error" & echo. & set /p "symbol=ENTER THE SYMBOL: "
if %symbol%==1 goto :C++Redist
if %symbol%==2 goto :7zip
if %symbol%==3 goto :Firefox
if %symbol%==4 goto :Chrome
if %symbol%==5 goto :Notepad++
if %symbol%==6 goto :Discord
if %symbol%==7 goto :Parsec
if %symbol%==8 goto :Steam
if %symbol%==9 goto :EpicGamesLauncher
if %symbol%==10 goto :Ubisoft
if %symbol%==11 goto :MicrosoftTeams
if %symbol%==12 goto :OBSStudio
if %symbol%==13 goto :ZeroTierOne
if %symbol%==14 goto :qBittorrent
if %symbol%==15 goto :SandboxiePlus
if %symbol%==16 goto :Viber
if %symbol%==17 goto :Java
if %symbol%==18 goto :PowerToys
if %symbol%==19 goto :KeePass
if %symbol%==20 goto :Malwarebytes
if %symbol%==21 goto :Zoom
if %symbol%==22 goto :VLC
if %symbol%==23 goto :CloudflareWarp
if %symbol%==* goto :endofthewingetfile
if %symbol%==0 goto :menu
if %symbol%==/ call :delete & goto :startofthewingetfile
goto :wingetmenu

:startofthewingetfile
echo {>> winget.json
echo    "$schema" : "https://aka.ms/winget-packages.schema.2.0.json",>> winget.json
echo    "CreationDate" : "2022-08",>> winget.json
echo    "Sources" : >> winget.json
echo    [>> winget.json
echo        {>> winget.json
echo            "Packages" : >> winget.json
echo            [>> winget.json
goto :wingetmenu

:C++Redist
if exist selected-apps.txt find /c "C++ Redistributable added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Microsoft.VC++2015-2022Redist-x64">> winget.json
echo                },>> winget.json
echo                {>> winget.json
echo                    "PackageIdentifier" : "Microsoft.VC++2015-2019Redist-x86">> winget.json
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
goto :wingetmenu

:7zip
if exist selected-apps.txt find /c "7zip added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "7zip.7zip">> winget.json
echo                },>> winget.json
echo 7zip added>> selected-apps.txt
goto :wingetmenu

:Firefox
if exist selected-apps.txt find /c "Firefox added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Mozilla.Firefox.ESR">> winget.json
echo                },>> winget.json
echo Firefox added>> selected-apps.txt
goto :wingetmenu

:Chrome
if exist selected-apps.txt find /c "Chrome added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Google.Chrome">> winget.json
echo                },>> winget.json
echo Chrome added>> selected-apps.txt
goto :wingetmenu

:Notepad++
if exist selected-apps.txt find /c "Notepad++ added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Notepad++.Notepad++">> winget.json
echo                },>> winget.json
echo Notepad++ added>> selected-apps.txt
goto :wingetmenu

:Discord
if exist selected-apps.txt find /c "Discord added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Discord.Discord">> winget.json
echo                },>> winget.json
echo Discord added>> selected-apps.txt
goto :wingetmenu

:Parsec
if exist selected-apps.txt find /c "Parsec added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Parsec.Parsec">> winget.json
echo                },>> winget.json
echo Parsec added>> selected-apps.txt
goto :wingetmenu

:Steam
if exist selected-apps.txt find /c "Steam added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Valve.Steam">> winget.json
echo                },>> winget.json
echo Steam added>> selected-apps.txt
goto :wingetmenu

:EpicGamesLauncher
if exist selected-apps.txt find /c "Epic Games Launcher added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "EpicGames.EpicGamesLauncher">> winget.json
echo                },>> winget.json
echo Epic Games Launcher added>> selected-apps.txt
goto :wingetmenu

:Ubisoft
if exist selected-apps.txt find /c "Ubisoft Connect added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Ubisoft.Connect">> winget.json
echo                },>> winget.json
echo Ubisoft Connect added>> selected-apps.txt
goto :wingetmenu

:MicrosoftTeams
if exist selected-apps.txt find /c "Microsoft Teams added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Microsoft.Teams">> winget.json
echo                },>> winget.json
echo Microsoft Teams added>> selected-apps.txt
goto :wingetmenu

:OBSStudio
if exist selected-apps.txt find /c "OBS Studio added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "OBSProject.OBSStudio">> winget.json
echo                },>> winget.json
echo OBS Studio added>> selected-apps.txt
goto :wingetmenu

:ZeroTierOne
if exist selected-apps.txt find /c "Zero Tier One added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "ZeroTier.ZeroTierOne">> winget.json
echo                },>> winget.json
echo Zero Tier One added>> selected-apps.txt
goto :wingetmenu

:qBittorrent
if exist selected-apps.txt find /c "qBittorrent added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "qBittorrent.qBittorrent">> winget.json
echo                },>> winget.json
echo qBittorrent added>> selected-apps.txt
goto :wingetmenu

:SandboxiePlus
if exist selected-apps.txt find /c "Sandboxie Plus added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Sandboxie.Plus">> winget.json
echo                },>> winget.json
echo Sandboxie Plus added>> selected-apps.txt
goto :wingetmenu

:Viber
if exist selected-apps.txt find /c "Viber added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Viber.Viber">> winget.json
echo                },>> winget.json
echo Viber added>> selected-apps.txt
goto :wingetmenu

:Java
if exist selected-apps.txt find /c "Java added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Oracle.JavaRuntimeEnvironment">> winget.json
echo                },>> winget.json
echo Java added>> selected-apps.txt
goto :wingetmenu

:PowerToys
if exist selected-apps.txt find /c "PowerToys added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Microsoft.PowerToys">> winget.json
echo                },>> winget.json
echo PowerToys added>> selected-apps.txt
goto :wingetmenu

:KeePass
if exist selected-apps.txt find /c "KeePass added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "DominikReichl.KeePass">> winget.json
echo                },>> winget.json
echo KeePass added>> selected-apps.txt
goto :wingetmenu

:Malwarebytes
if exist selected-apps.txt find /c "Malwarebytes added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Malwarebytes.Malwarebytes">> winget.json
echo                },>> winget.json
echo Malwarebytes added>> selected-apps.txt
goto :wingetmenu

:Zoom
if exist selected-apps.txt find /c "Zoom added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Zoom.Zoom">> winget.json
echo                },>> winget.json
echo Zoom added>> selected-apps.txt
goto :wingetmenu

:VLC
if exist selected-apps.txt find /c "VLC added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "VideoLAN.VLC">> winget.json
echo                },>> winget.json
echo VLC added>> selected-apps.txt
goto :wingetmenu

:CloudflareWarp
if exist selected-apps.txt find /c "Cloudflare Warp added" selected-apps.txt >nul && goto :wingetmenu
echo                {>> winget.json
echo                    "PackageIdentifier" : "Cloudflare.Warp">> winget.json
echo                },>> winget.json
echo Cloudflare Warp added>> selected-apps.txt
goto :wingetmenu

:endofthewingetfile
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

echo %breakline% & %print% FILE CREATED & pause
echo %breakline% & %print% WINGET.JSON INITIALIZATION
winget import -i .\winget.json --accept-source-agreements --accept-package-agreements
pause & goto :menu

:delete
if exist winget.json del winget.json 2>nul & del selected-apps.txt 2>nul & rmdir /s /q %Temp%\WinGet\ 2>nul 
if exist settings.reg del settings.reg 2>nul
goto :eof
