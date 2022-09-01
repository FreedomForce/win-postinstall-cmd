@echo off
title win-postinstall-cmd                         
cd /d %~dp0
set breakline=------------------------------------------------------------------------------------------
set "print=echo. & echo"

:menu
cls & call :delete
%print% SELECT YOUR TASK: & echo.
echo: [1] TWEAKS
echo: [2] IMPORT SETTINGS
echo: [3] INSTALL APPLICATIONS

set "number=Error" & echo. & set /p number= ENTER THE NUMBER: 
if %number%==1 goto :tweaks
if %number%==2 goto :registry
if %number%==3 goto :winget
goto :menu

rem                     FIRST CHAPTER - UPDATES AND USER SETTINGS
:tweaks
cls & %print% SELECT YOUR TASK: & echo.
echo: [1] CHECK IF WINGET IS INSTALLED
echo: [2] CHECK FOR UPDATES
echo: [3] DISABLE HIBERNATE
echo: [4] DISABLE PASSWORD EXPIRATION
echo: [5] OPEN OLD MIXER
%print% [0] GO BACK

set "number=Error" & echo. & set /p number=ENTER THE NUMBER: 
if %number%==0 goto :menu
if %number%==1 goto :update_winget
if %number%==2 goto :update_windows
if %number%==3 goto :disable_hibernate
if %number%==4 goto :disable_passwordexp
if %number%==5 goto :open_oldmixer
goto :tweaks

:update_winget
start ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1
goto :tweaks

:update_windows
start ms-settings:windowsupdate-action
goto :tweaks

:disable_hibernate
echo. & powercfg /h off && powercfg /a |more
pause & goto :tweaks

:disable_passwordexp
echo. & wmic UserAccount where "Name='%username%'" set PasswordExpires=False
pause & goto :tweaks

:open_oldmixer
sndvol.exe
goto :tweaks

rem                     SECOND CHAPTER - REGISTRY KEYS
:registry
cls & %print% SELECT YOUR TASK: & echo.
echo: [1] Remove chat from taskbar                             [2] Remove Cortana from taskbar 
echo: [3] Remove task view from taskbar                        [4] Remove search from taskbar
echo: [5] Remove meet now                                      [6] Remove news and interests
echo: [7] Remove taskbar pins                                  [8] Remove Widgets from the Taskbar
echo: [9] Always hide most used list in start menu             [10] Disable show recently added apps
echo: [11] Disable "Show recently opened items in Start..."    [12] Disable Compact Mode
echo: [13] Open file explorer to This PC                       [14] Show file name extensions
echo: [15] Sound communications do nothing                     [16] Disable startup sound 
echo: [17] Turn off enhance pointer precision                  [18] Disable automatic maintenance
echo: [19] Disable "use my sign in info after restart"         [20] Alt tab open windows only
echo: [21] Restore the classic context menu                    [22] Disable "Suggest ways to get the most out of Windows..."
echo: [23] Disable "Windows Experience ..."                    [24] Disable "Get tips and suggestions when using Windows"
echo: [25] Enable NumLock by default                           [26] Disable ease of access settings (Narrator + Sticky Keys)
echo: [27] Enable file explorer checkboxes
%print% [0] GO BACK & echo [*] SELECT ALL

set "symbol=Error" & echo. & set /p symbol=ENTER THE SYMBOL: 
if %symbol%==* call :registry_allkeys
if %symbol%==0 call :menu
if %symbol%==1 call :rm_chat >nul 2>&1
if %symbol%==2 call :rm_cortana_icon >nul 2>&1
if %symbol%==3 call :rm_taskview_icon >nul 2>&1
if %symbol%==4 call :rm_search_icon >nul 2>&1
if %symbol%==5 call :rm_meet_icon >nul 2>&1
if %symbol%==6 call :rm_newsandinterests_icon >nul 2>&1
if %symbol%==7 call :rm_taskbarpins >nul 2>&1
if %symbol%==8 call :rm_widgetsfromthetaskbar_icon >nul 2>&1
if %symbol%==9 call :hide_mostusedlist >nul 2>&1
if %symbol%==10 call :disable_showrecentlyaddedapps >nul 2>&1
if %symbol%==11 call :disable_showrecentlyopened >nul 2>&1
if %symbol%==12 call :disable_compactmode >nul 2>&1
if %symbol%==13 call :enable_openfileexplorer >nul 2>&1
if %symbol%==14 call :enable_filenameextensions >nul 2>&1
if %symbol%==15 call :enable_soundcommunications >nul 2>&1
if %symbol%==16 call :disable_startupsound >nul 2>&1
if %symbol%==17 call :disable_enhancepointerprecision >nul 2>&1
if %symbol%==18 call :disable_automaticmaintenance >nul 2>&1
if %symbol%==19 call :disable_usemysignininfo >nul 2>&1
if %symbol%==20 call :enable_alttabopenwindowsonly >nul 2>&1
if %symbol%==21 call :enable_classiccontextmenu >nul 2>&1
if %symbol%==22 call :disable_suggestways >nul 2>&1
if %symbol%==23 call :disable_windowsexperience >nul 2>&1
if %symbol%==24 call :disable_tipsandsuggestions >nul 2>&1
if %symbol%==25 call :enable_numlock >nul 2>&1
if %symbol%==26 call :disable_easeofaccesssettings >nul 2>&1
if %symbol%==27 call :enable_checkboxes >nul 2>&1
goto :registry

:rm_chat
rem          Remove chat from taskbar
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v TaskbarMn /t REG_DWORD /d 00000000
goto :eof

:rm_cortana_icon
rem          Remove Cortana from taskbar
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v ShowCortanaButton /t REG_DWORD /d 00000000
goto :eof

:rm_taskview_icon
rem          Remove task view from taskbar
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v ShowTaskViewButton /t REG_DWORD /d 00000000
goto :eof

:rm_search_icon
rem          Remove search from taskbar
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /f /v SearchboxTaskbarMode /t REG_DWORD /d 00000000
goto :eof

:rm_meet_icon
rem          Remove meet now
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v HideSCAMeetNow /t REG_DWORD /d 00000001
goto :eof

:rm_newsandinterests_icon
rem          Remove news and interests
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /f /v EnableFeeds /t REG_DWORD /d 00000000
goto :eof

:rm_taskbarpins
rem          Remove taskbar pins
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /f /va
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband\AuxilliaryPins" /f
goto :eof

:rm_widgetsfromthetaskbar_icon
rem          Remove Widgets from the Taskbar
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v TaskbarDa /t REG_DWORD /d 00000000
goto :eof

:hide_mostusedlist
rem          Always hide most used list in start menu
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /f /v ShowOrHideMostUsedApps /t REG_DWORD /d 00000002
reg delete "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /f /v ShowOrHideMostUsedApps
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoStartMenuMFUprogramsList
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoInstrumentation
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoStartMenuMFUprogramsList
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoInstrumentation
goto :eof

:disable_showrecentlyaddedapps
rem          Disable show recently added apps
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /f /v HideRecentlyAddedApps /t REG_DWORD /d 00000001
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v HideRecentlyAddedApps /t REG_DWORD /d 00000001
goto :eof

:disable_showrecentlyopened
rem          Disable show recently opened items in start, jump lists and file explorer
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v Start_TrackDocs /t REG_DWORD /d 00000000
goto :eof

:disable_compactmode
rem          Disable Compact Mode
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v UseCompactMode /t REG_DWORD /d 00000001
goto :eof

:enable_openfileexplorer
rem          Open file explorer to this pc
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v LaunchTo /t REG_DWORD /d 00000001
goto :eof

:enable_filenameextensions
rem          Show file name extensions
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v HideFileExt /t REG_DWORD /d 00000000
goto :eof

:enable_soundcommunications
rem          Sound communications do nothing
reg add "HKEY_CURRENT_USER\Software\Microsoft\Multimedia\Audio" /f /v UserDuckingPreference /t REG_DWORD /d 00000003
goto :eof

:disable_startupsound
rem          Disable startup sound
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation" /f /v DisableStartupSound /t REG_DWORD /d 00000001
goto :eof

:disable_enhancepointerprecision
rem          Turn off enhance pointer precision
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /f /v MouseSpeed /t REG_DWORD /d 0
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /f /v MouseThreshold1 /t REG_DWORD /d 0
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /f /v MouseThreshold2 /t REG_DWORD /d 0
goto :eof

:disable_automaticmaintenance
rem          Disable automatic maintenance
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /f /v MaintenanceDisabled /t REG_DWORD /d 00000001
goto :eof

:disable_usemysignininfo
rem          Disable use my sign in info after restart
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /f /v DisableAutomaticRestartSignOn /t REG_DWORD /d 00000001
goto :eof

:enable_alttabopenwindowsonly
rem          Alt tab open windows only
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v MultiTaskingAltTabFilter /t REG_DWORD /d 00000003
goto :eof

:enable_classiccontextmenu
rem          Restore the classic context menu 4 w11
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
goto :eof

:disable_suggestways
rem          Disable "Suggest ways to get the most out of Windows and finish setting up this device"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /f /v ScoobeSystemSettingEnabled /t REG_DWORD /d 00000000
goto :eof

:disable_windowsexperience
rem          Disable "Windows Experience ..."
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f /v SubscribedContent-310093Enabled /t REG_DWORD /d 00000000
goto :eof

:disable_tipsandsuggestions
rem          Disable "Get tips and suggestions when using Windows"
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f /v SubscribedContent-338389Enabled /t REG_DWORD /d 00000000
goto :eof

:enable_numlock
rem          Enable NumLock by default
reg add "HKEY_USERS\.DEFAULT\Control Panel\Keyboard" /f /v InitialKeyboardIndicators /t REG_DWORD /d 2147483650
goto :eof

:disable_easeofaccesssettings
rem          Disable ease of access settings
reg add "HKEY_CURRENT_USER\Software\Microsoft\Ease of Access" /f /v selfvoice /t REG_DWORD /d 00000000
reg add "HKEY_CURRENT_USER\Software\Microsoft\Ease of Access" /f /v selfscan /t REG_DWORD /d 00000000
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys" /f /v Flags /t REG_DWORD /d 2
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\ToggleKeys" /f /v Flags /t REG_DWORD /d 34
goto :eof

:enable_checkboxes
rem          Enable file explorer checkboxes
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v AutoCheckSelect /t REG_DWORD /d 1
goto :eof

:registry_allkeys
call :rm_chat >nul 2>&1
call :rm_cortana_icon >nul 2>&1
call :rm_taskview_icon >nul 2>&1
call :rm_search_icon >nul 2>&1
call :rm_meet_icon >nul 2>&1
call :rm_newsandinterests_icon >nul 2>&1
call :rm_taskbarpins >nul 2>&1
call :rm_widgetsfromthetaskbar_icon >nul 2>&1
call :hide_mostusedlist >nul 2>&1
call :disable_showrecentlyaddedapps >nul 2>&1
call :disable_showrecentlyopened >nul 2>&1
call :disable_compactmode >nul 2>&1
call :enable_openfileexplorer >nul 2>&1
call :enable_filenameextensions >nul 2>&1
call :enable_soundcommunications >nul 2>&1
call :disable_startupsound >nul 2>&1
call :disable_enhancepointerprecision >nul 2>&1
call :disable_automaticmaintenance >nul 2>&1
call :disable_usemysignininfo >nul 2>&1
call :enable_alttabopenwindowsonly >nul 2>&1
call :enable_classiccontextmenu >nul 2>&1
call :disable_suggestways >nul 2>&1
call :disable_windowsexperience >nul 2>&1
call :disable_tipsandsuggestions >nul 2>&1
call :enable_numlock >nul 2>&1
call :disable_easeofaccesssettings >nul 2>&1
call :enable_checkboxes >nul 2>&1
goto :registry

rem                     THIRD CHAPTER - WINGET
:winget
goto :startofthewingetfile

:wingetmenu
cls & %print% SELECT WHAT TO INSTALL: & echo.
echo: [1] C++ Redistributables        [2] 7zip                        [3] Firefox
echo: [4] Chrome                      [5] Notepad++                   [6] Discord
echo: [7] Parsec                      [8] Steam                       [9] Epic Games Launcher
echo: [10] Ubisoft Connect            [11] Microsoft Teams            [12] OBS Studio
echo: [13] Zero Tier One              [14] qBittorrent                [15] Sandboxie Plus
echo: [16] Viber                      [17] Java                       [18] PowerToys
echo: [19] KeePass                    [20] Malwarebytes               [21] Zoom
echo: [22] VLC                        [23] Cloudflare Warp            [24] Chocolatey GUI
echo: [25] .NET Framework
%print% [*] CREATE FILE & echo [0] GO BACK
if exist selected-apps.txt echo [/] CLEAR LIST OF SELECTED APPS & echo %breakline% & %print% SELECTED APPS: & type selected-apps.txt 2>nul

set "symbol=Error" & echo. & set /p symbol=ENTER THE SYMBOL: 
if %symbol%==0 goto :menu
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
if %symbol%==24 goto :ChocolateyGUI
if %symbol%==25 goto :dotNetFramework
if %symbol%==* goto :endofthewingetfile
if %symbol%==/ call :delete & goto :startofthewingetfile
goto :wingetmenu

:startofthewingetfile
echo {>> winget.json
echo    "$schema" : "https://aka.ms/winget-packages.schema.2.0.json",>> winget.json
echo    "CreationDate" : "2022-09",>> winget.json
echo    "Sources" : >> winget.json
echo    [>> winget.json
echo        {>> winget.json
echo            "Packages" : >> winget.json
echo            [>> winget.json
goto :wingetmenu

:C++Redist
if exist selected-apps.txt find /c "C++ Redistributable added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=Microsoft.VC++2015-2022Redist-x64
call :winget_app
set wingetapp=Microsoft.VC++2015-2019Redist-x86
call :winget_app
set wingetapp=Microsoft.VC++2013Redist-x86
call :winget_app
set wingetapp=Microsoft.VC++2013Redist-x64
call :winget_app
set wingetapp=Microsoft.VC++2012Redist-x86
call :winget_app
set wingetapp=Microsoft.VC++2012Redist-x64
call :winget_app
set wingetapp=Microsoft.VC++2010Redist-x86
call :winget_app
set wingetapp=Microsoft.VC++2008Redist-x86
call :winget_app
set wingetapp=Microsoft.VC++2008Redist-x64
call :winget_app
set wingetapp=Microsoft.VC++2005Redist-x86
call :winget_app
set wingetapp=Microsoft.VC++2005Redist-x64
call :winget_app
echo C++ Redistributable added>> selected-apps.txt
goto :wingetmenu

:7zip
if exist selected-apps.txt find /c "7zip added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=7zip.7zip
call :winget_app
echo 7zip added>> selected-apps.txt
goto :wingetmenu

:Firefox
if exist selected-apps.txt find /c "Firefox added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=Mozilla.Firefox.ESR
call :winget_app
echo Firefox added>> selected-apps.txt
goto :wingetmenu

:Chrome
if exist selected-apps.txt find /c "Chrome added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=Google.Chrome
call :winget_app
echo Chrome added>> selected-apps.txt
goto :wingetmenu

:Notepad++
if exist selected-apps.txt find /c "Notepad++ added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=Notepad++.Notepad++
call :winget_app
echo Notepad++ added>> selected-apps.txt
goto :wingetmenu

:Discord
if exist selected-apps.txt find /c "Discord added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=Discord.Discord
call :winget_app
echo Discord added>> selected-apps.txt
goto :wingetmenu

:Parsec
if exist selected-apps.txt find /c "Parsec added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=Parsec.Parsec
call :winget_app
echo Parsec added>> selected-apps.txt
goto :wingetmenu

:Steam
if exist selected-apps.txt find /c "Steam added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=Valve.Steam
call :winget_app
echo Steam added>> selected-apps.txt
goto :wingetmenu

:EpicGamesLauncher
if exist selected-apps.txt find /c "Epic Games Launcher added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=EpicGames.EpicGamesLauncher
call :winget_app
echo Epic Games Launcher added>> selected-apps.txt
goto :wingetmenu

:Ubisoft
if exist selected-apps.txt find /c "Ubisoft Connect added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=Ubisoft.Connect
call :winget_app
echo Ubisoft Connect added>> selected-apps.txt
goto :wingetmenu

:MicrosoftTeams
if exist selected-apps.txt find /c "Microsoft Teams added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=Microsoft.Teams
call :winget_app
echo Microsoft Teams added>> selected-apps.txt
goto :wingetmenu

:OBSStudio
if exist selected-apps.txt find /c "OBS Studio added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=OBSProject.OBSStudio
call :winget_app
echo OBS Studio added>> selected-apps.txt
goto :wingetmenu

:ZeroTierOne
if exist selected-apps.txt find /c "Zero Tier One added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=ZeroTier.ZeroTierOne
call :winget_app
echo Zero Tier One added>> selected-apps.txt
goto :wingetmenu

:qBittorrent
if exist selected-apps.txt find /c "qBittorrent added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=qBittorrent.qBittorrent
call :winget_app
echo qBittorrent added>> selected-apps.txt
goto :wingetmenu

:SandboxiePlus
if exist selected-apps.txt find /c "Sandboxie Plus added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=Sandboxie.Plus
call :winget_app
echo Sandboxie Plus added>> selected-apps.txt
goto :wingetmenu

:Viber
if exist selected-apps.txt find /c "Viber added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=Viber.Viber
call :winget_app
echo Viber added>> selected-apps.txt
goto :wingetmenu

:Java
if exist selected-apps.txt find /c "Java added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=Oracle.JavaRuntimeEnvironment
call :winget_app
echo Java added>> selected-apps.txt
goto :wingetmenu

:PowerToys
if exist selected-apps.txt find /c "PowerToys added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=Microsoft.PowerToys
call :winget_app
echo PowerToys added>> selected-apps.txt
goto :wingetmenu

:KeePass
if exist selected-apps.txt find /c "KeePass added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=DominikReichl.KeePass
call :winget_app
echo KeePass added>> selected-apps.txt
goto :wingetmenu

:Malwarebytes
if exist selected-apps.txt find /c "Malwarebytes added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=Malwarebytes.Malwarebytes
call :winget_app
echo Malwarebytes added>> selected-apps.txt
goto :wingetmenu

:Zoom
if exist selected-apps.txt find /c "Zoom added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=Zoom.Zoom
call :winget_app
echo Zoom added>> selected-apps.txt
goto :wingetmenu

:VLC
if exist selected-apps.txt find /c "VLC added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=VideoLAN.VLC
call :winget_app
echo VLC added>> selected-apps.txt
goto :wingetmenu

:CloudflareWarp
if exist selected-apps.txt find /c "Cloudflare Warp added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=Cloudflare.Warp
call :winget_app
echo Cloudflare Warp added>> selected-apps.txt
goto :wingetmenu

:ChocolateyGUI
if exist selected-apps.txt find /c "Chocolatey added" selected-apps.txt >nul && goto :wingetmenu
powershell Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
set wingetapp=Chocolatey.ChocolateyGUI
call :winget_app
echo Chocolatey added>> selected-apps.txt
goto :wingetmenu

:dotNetFramework
if exist selected-apps.txt find /c ".NET Framework added" selected-apps.txt >nul && goto :wingetmenu
set wingetapp=Microsoft.dotNetFramework
call :winget_app
echo .NET Framework added>> selected-apps.txt
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

echo %breakline% & %print% FILE CREATED. PRESS ANY KEY TO INITIALIZE WINGET.JSON & pause
winget import -i .\winget.json --accept-source-agreements --accept-package-agreements
pause & goto :menu

:winget_app
echo                {>> winget.json
echo                    "PackageIdentifier" : "%wingetapp%">> winget.json
echo                },>> winget.json
goto :eof

:delete
if exist winget.json del winget.json 2>nul & del selected-apps.txt 2>nul & rmdir /s /q %Temp%\WinGet\ 2>nul 
goto :eof
