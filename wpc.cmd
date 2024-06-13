@echo off
rem                     https://github.com/FreedomForce/win-postinstall-cmd

title win-postinstall-cmd
if not "%1"=="am_admin" call powershell -h | %WINDIR%\System32\find.exe /i "powershell" > nul && if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin > nul & exit)
setlocal EnableDelayedExpansion
mode con: cols=145 lines=30
title win-postinstall-cmd
cd /d %~dp0

rem                     variables
rem set "env=debug" & @echo on
rem "output=%Temp%\wpc_debug.txt"
set "breakline=__________________________________________________________________________________________"
set "print=echo. & echo"
set "mute=>nul 2>&1"
set Version=
for /f "tokens=2 delims==" %%a in ('wmic os get Caption /value') do set Version=%%a
if "%Version:~0,20%"=="Microsoft Windows 10" ( set "winversion=win10" ) else set "winversion=win11"

rem                     winget_variables
set "app_list_file=%Temp%\selected-apps.txt"
set "winget_file=%Temp%\winget.json"

:menu
cls & call :delete
%print% SELECT YOUR TASK: & echo.
echo: [1] Tweaks
echo: [2] Import settings
echo: [3] Install applications

set "number=Error" & echo. & set /p number=ENTER THE NUMBER: 
if %number%==1 goto :tweaks
if %number%==2 goto :registry
if %number%==3 goto :wingetmenu

rem                     FIRST CHAPTER - UPDATES AND USER SETTINGS
:tweaks
cls & %print% SELECT YOUR TASK: & echo.
echo: [1] Check if winget is installed
echo: [2] Check for updates
echo: [3] Disable hibernate
echo: [4] Disable password expiration
echo: [5] Open old mixer
%print% [0] Go back

set "number=Error" & echo. & set /p number=ENTER THE NUMBER: 
if %number%==0 goto :menu
if %number%==1 goto :update_winget
if %number%==2 goto :update_windows
if %number%==3 goto :disable_hibernate
if %number%==4 goto :disable_passwordExp
if %number%==5 goto :open_oldMixer
goto :tweaks

:update_winget
start ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1
goto :tweaks

:update_windows
start ms-settings:windowsupdate
goto :tweaks

:disable_hibernate
echo. & powercfg /h off && powercfg /a |more
pause & goto :tweaks

:disable_passwordExp
echo. & wmic UserAccount where "Name='%username%'" set PasswordExpires=False
pause & goto :tweaks

:open_oldMixer
sndvol.exe
goto :tweaks

rem                     SECOND CHAPTER - REGISTRY KEYS
:registry
cls & %print% SELECT YOUR TASK: & echo.
echo: [1] Remove chat from taskbar                             [2] Remove Cortana from taskbar 
echo: [3] Remove task view from taskbar                        [4] Remove search from taskbar
echo: [5] Remove meet now                                      [6] Remove news and interests
echo: [7] Remove taskbar pins                                  [8] Remove Widgets from the Taskbar
echo: [9] Always hide most used list in start menu             [10] Disable show recently added apps (Win10)
echo: [11] Disable "Show recently opened items in Start..."    [12] Enable Compact Mode
echo: [13] Open file explorer to - This PC                     [14] Show file name extensions
echo: [15] Sound communications - do nothing                   [16] Disable startup sound 
echo: [17] Turn off enhance pointer precision                  [18] Disable automatic maintenance
echo: [19] Disable "Use my sign in info after restart"         [20] Alt tab - open windows only
echo: [21] Disable "Suggest ways to get the most out of Win..."[22] Disable "Windows Experience ..."
echo: [23] Disable "Get tips and suggestions when using Win..."[24] Enable NumLock by default
echo: [25] Disable (Narrator + Sticky Keys)                    [26] Enable file explorer checkboxes
echo: [27] Different input method for each app window
%print% [0] Go back & echo [*] Select all & echo [/] Restore settings

set "symbol=Error" & echo. & set /p symbol=ENTER THE SYMBOL: 

:reg_imp_select
if %symbol%==/  goto :registry_restore
if %symbol%==*  goto :registry_all_keys
if %symbol%==0  call :menu
if %symbol%==1  call :import_chat                       %mute%
if %symbol%==2  call :import_cortana_icon               %mute%
if %symbol%==3  call :import_TaskView_icon              %mute%
if %symbol%==4  call :import_search_icon                %mute%
if %symbol%==5  call :import_meet_icon                  %mute%
if %symbol%==6  call :import_NewsAndInterests_icon      %mute%
if %symbol%==7  call :import_TaskbarPins                %mute%
if %symbol%==8  call :import_WidgetsFromTheTaskbar_icon %mute%
if %symbol%==9  call :import_MostUsedList               %mute%
if %symbol%==10 call :import_ShowRecentlyAddedApps      %mute%
if %symbol%==11 call :import_ShowRecentlyOpened         %mute%
if %symbol%==12 call :import_CompactMode                %mute%
if %symbol%==13 call :import_OpenFileExplorer           %mute%
if %symbol%==14 call :import_FileNameExtensions         %mute%
if %symbol%==15 call :import_SoundCommunications        %mute%
if %symbol%==16 call :import_StartupSound               %mute%
if %symbol%==17 call :import_EnhancePointerPrecision    %mute%
if %symbol%==18 call :import_AutomaticMaintenance       %mute%
if %symbol%==19 call :import_UseMySignInInfo            %mute%
if %symbol%==20 call :import_AltTab                     %mute%
if %symbol%==21 call :import_SuggestWays                %mute%
if %symbol%==22 call :import_WindowsExperience          %mute%
if %symbol%==23 call :import_TipsAndSuggestions         %mute%
if %symbol%==24 call :import_NumLock                    %mute%
if %symbol%==25 call :import_EaseOfAccessSettings       %mute%
if %symbol%==26 call :import_CheckBoxes                 %mute%
if %symbol%==27 call :import_DifferentInputMethod       %mute%
if "%loop%"=="1" goto :eof
if NOT "%loop%"=="1" goto :registry

:registry_all_keys
set "loop=1"
for /L %%i in (1,1,28) do (
    set "symbol=%%i"
    call :reg_imp_select
)
set "loop=0"
goto :registry

:import_chat
rem          Remove chat from taskbar
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v TaskbarMn /t REG_DWORD /d 00000000
goto :eof

:import_cortana_icon
rem          Remove Cortana from taskbar
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v ShowCortanaButton /t REG_DWORD /d 00000000
goto :eof

:import_TaskView_icon
rem          Remove task view from taskbar
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v ShowTaskViewButton /t REG_DWORD /d 00000000
goto :eof

:import_search_icon
rem          Remove search from taskbar
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /f /v SearchboxTaskbarMode /t REG_DWORD /d 00000000
goto :eof

:import_meet_icon
rem          Remove meet now
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v HideSCAMeetNow /t REG_DWORD /d 00000001
goto :eof

:import_NewsAndInterests_icon
rem          Remove news and interests
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Windows Feeds" /f /v EnableFeeds /t REG_DWORD /d 00000000
goto :eof

:import_TaskbarPins
rem          Remove taskbar pins
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /f /va
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband\AuxilliaryPins" /f
goto :eof

:import_WidgetsFromTheTaskbar_icon
rem          Remove Widgets from the Taskbar
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v TaskbarDa /t REG_DWORD /d 00000000
goto :eof

:import_MostUsedList
rem          Always hide most used list in start menu
if %winversion%==win10  goto :win10_MostUsedList                       %mute%
if %winversion%==win11  goto :win11_MostUsedList                       %mute%

:win10_MostUsedList
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoStartMenuMFUprogramsList /t REG_DWORD /d 00000001
goto :eof

:win11_MostUsedList
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Explorer" /f /v ShowOrHideMostUsedApps /t REG_DWORD /d 00000002
reg add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /f /v ShowOrHideMostUsedApps
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoStartMenuMFUprogramsList
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoInstrumentation
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoStartMenuMFUprogramsList
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v NoInstrumentation
goto :eof

:import_ShowRecentlyAddedApps
rem          Disable show recently added apps
if %winversion%==win10  goto :win10_RecentlyAddedApps                       %mute%
if %winversion%==win11  goto :eof

:win10_RecentlyAddedApps
reg add "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Explorer" /f /v HideRecentlyAddedApps /t REG_DWORD /d 00000001
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v HideRecentlyAddedApps /t REG_DWORD /d 00000001
goto :eof

:import_ShowRecentlyOpened
rem          Disable show recently opened items in start, jump lists and file explorer
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v Start_TrackDocs /t REG_DWORD /d 00000000
goto :eof

:import_CompactMode
rem          Enable Compact Mode
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v UseCompactMode /t REG_DWORD /d 00000001
goto :eof

:import_OpenFileExplorer
rem          Open file explorer to this pc
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v LaunchTo /t REG_DWORD /d 00000001
goto :eof

:import_FileNameExtensions
rem          Show file name extensions
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v HideFileExt /t REG_DWORD /d 00000000
goto :eof

:import_SoundCommunications
rem          Sound communications do nothing
reg add "HKEY_CURRENT_USER\Software\Microsoft\Multimedia\Audio" /f /v UserDuckingPreference /t REG_DWORD /d 00000003
goto :eof

:import_StartupSound
rem          Disable startup sound
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation" /f /v DisableStartupSound /t REG_DWORD /d 00000001
goto :eof

:import_EnhancePointerPrecision
rem          Turn off enhance pointer precision
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /f /v MouseSpeed /t REG_SZ /d 0
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /f /v MouseThreshold1 /t REG_SZ /d 0
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /f /v MouseThreshold2 /t REG_SZ /d 0
goto :eof

:import_AutomaticMaintenance
rem          Disable automatic maintenance
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /f /v MaintenanceDisabled /t REG_DWORD /d 00000001
goto :eof

:import_UseMySignInInfo
rem          Disable use my sign in info after restart
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /f /v DisableAutomaticRestartSignOn /t REG_DWORD /d 00000001
goto :eof

:import_AltTab
rem          Alt tab open windows only
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v MultiTaskingAltTabFilter /t REG_DWORD /d 00000003
goto :eof

:import_SuggestWays
rem          Disable "Suggest ways to get the most out of Windows and finish setting up this device"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /f /v ScoobeSystemSettingEnabled /t REG_DWORD /d 00000000
goto :eof

:import_WindowsExperience
rem          Disable "Windows Experience..."
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f /v SubscribedContent-310093Enabled /t REG_DWORD /d 00000000
goto :eof

:import_TipsAndSuggestions
rem          Disable "Get tips and suggestions when using Windows"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f /v SubscribedContent-338389Enabled /t REG_DWORD /d 00000000
goto :eof

:import_NumLock
rem          Enable NumLock by default
reg add "HKEY_USERS\.DEFAULT\Control Panel\Keyboard" /f /v InitialKeyboardIndicators /t REG_SZ /d 2147483650
goto :eof

:import_EaseOfAccessSettings
rem          Disable ease of access settings
reg add "HKEY_CURRENT_USER\Software\Microsoft\Ease of Access" /f /v selfvoice /t REG_DWORD /d 00000000
reg add "HKEY_CURRENT_USER\Software\Microsoft\Ease of Access" /f /v selfscan /t REG_DWORD /d 00000000
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys" /f /v Flags /t REG_SZ /d 2
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\ToggleKeys" /f /v Flags /t REG_SZ /d 34
goto :eof

:import_CheckBoxes
rem          Enable file explorer checkboxes
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v AutoCheckSelect /t REG_DWORD /d 1
goto :eof

:import_DifferentInputMethod
rem          Let me use a different input method for each app window
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /f /v UserPreferencesMask /t REG_BINARY /d 9e1e068092000000
goto :eof

:registry_restore
cls & %print% SELECT YOUR TASK: & echo.
echo: [1] Restore chat on taskbar                                               [2] Restore Cortana on taskbar 
echo: [3] Restore task view on taskbar                                          [4] Restore search on taskbar
echo: [5] Restore meet now                                                      [6] Restore news and interests
echo: [7] Restore Widgets on the Taskbar                                        [8] Disable "Always hide most used list in start menu"
echo: [9] Enable show recently added apps                                       [10] Enable "Show recently opened items in Start..."
echo: [11] Disable Compact Mode                                                 [12] Open file explorer to - Quick access
echo: [13] Disable Show file name extensions                                    [14] Restore Sound communications tab
echo: [15] Enable startup sound                                                 [16] Restore enhance pointer precision
echo: [17] Enable automatic maintenance                                         [18] Enable "Use my sign in info after restart"
echo: [19] Alt tab open - Open windows and 5 most recent...                     [20] Enable "Suggest ways to get the most out of Windows..."
echo: [21] Enable "Windows Experience ..."                                      [22] Enable "Get tips and suggestions when using Windows"
echo: [23] Disable NumLock by default                                           [24] Enable Narrator + Sticky Keys
echo: [25] Disable file explorer checkboxes                                     [26] Disable "Let me use a different input method for each app window"
%print% [0] Go back & echo [*] Select all

set "symbol=Error" & echo. & set /p symbol=ENTER THE SYMBOL: 

:reg_res_select
if %symbol%==*  goto :registry_restore_all_keys
if %symbol%==0  goto :registry
if %symbol%==1  call :restore_chat                       %mute%
if %symbol%==2  call :restore_cortana_icon               %mute%
if %symbol%==3  call :restore_TaskView_icon              %mute%
if %symbol%==4  call :restore_search_icon                %mute%
if %symbol%==5  call :restore_meet_icon                  %mute%
if %symbol%==6  call :restore_NewsAndInterests_icon      %mute%
if %symbol%==7  call :restore_WidgetsFromTheTaskbar_icon %mute%
if %symbol%==8  call :restore_MostUsedList               %mute%
if %symbol%==9  call :restore_ShowRecentlyAddedApps      %mute%
if %symbol%==10 call :restore_ShowRecentlyOpened         %mute%
if %symbol%==11 call :restore_CompactMode                %mute%
if %symbol%==12 call :restore_OpenFileExplorer           %mute%
if %symbol%==13 call :restore_FileNameExtensions         %mute%
if %symbol%==14 call :restore_SoundCommunications        %mute%
if %symbol%==15 call :restore_StartupSound               %mute%
if %symbol%==16 call :restore_EnhancePointerPrecision    %mute%
if %symbol%==17 call :restore_AutomaticMaintenance       %mute%
if %symbol%==18 call :restore_UseMySignInInfo            %mute%
if %symbol%==19 call :restore_AltTab                     %mute%
if %symbol%==20 call :restore_SuggestWays                %mute%
if %symbol%==21 call :restore_WindowsExperience          %mute%
if %symbol%==22 call :restore_TipsAndSuggestions         %mute%
if %symbol%==23 call :restore_NumLock                    %mute%
if %symbol%==24 call :restore_EaseOfAccessSettings       %mute%
if %symbol%==25 call :restore_CheckBoxes                 %mute%
if %symbol%==26 call :restore_DifferentInputMethod       %mute%
if "%loop%"=="1" goto :eof
if NOT "%loop%"=="1" goto :registry_restore

:registry_restore_all_keys
set "loop=1"
for /L %%i in (1,1,27) do (
    set "symbol=%%i"
    call :reg_res_select
)
set "loop=0"
goto :registry_restore

:restore_chat
rem          Restore chat on taskbar
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v TaskbarMn
goto :eof

:restore_cortana_icon
rem          Restore Cortana on taskbar
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v ShowCortanaButton
goto :eof

:restore_TaskView_icon
rem          Restore task view on taskbar
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v ShowTaskViewButton
goto :eof

:restore_search_icon
rem          Restore search on taskbar
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /f /v SearchboxTaskbarMode
goto :eof

:restore_meet_icon
rem          Restore meet now
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v HideSCAMeetNow
goto :eof

:restore_NewsAndInterests_icon
rem          Restore news and interests
reg delete "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Windows Feeds" /f /v EnableFeeds
goto :eof

:restore_WidgetsFromTheTaskbar_icon
rem          Remove Widgets from the Taskbar
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v TaskbarDa
goto :eof

:restore_MostUsedList
rem          Disable "Always hide most used list in start menu"
reg delete "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Explorer" /f /v ShowOrHideMostUsedApps
goto :eof

:restore_ShowRecentlyAddedApps
rem          Enable show recently added apps
reg delete "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Explorer" /f /v HideRecentlyAddedApps
reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v HideRecentlyAddedApps
goto :eof

:restore_ShowRecentlyOpened
rem          Enable "Show recently opened items in Start..."
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v Start_TrackDocs
goto :eof

:restore_CompactMode
rem          Disable Compact Mode
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v UseCompactMode
goto :eof

:restore_OpenFileExplorer
rem          Open file explorer to - Quick access
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v LaunchTo
goto :eof

:restore_FileNameExtensions
rem          Disable Show file name extensions
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v HideFileExt /t REG_DWORD /d 00000001
goto :eof

:restore_SoundCommunications
rem          Restore Sound communications tab
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Multimedia\Audio" /f /v UserDuckingPreference
goto :eof

:restore_StartupSound
rem          Enable startup sound
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation" /f /v DisableStartupSound /t REG_DWORD /d 00000000
goto :eof

:restore_EnhancePointerPrecision
rem          Restore enhance pointer precision
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /f /v MouseSpeed /t REG_SZ /d 1
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /f /v MouseThreshold1 /t REG_SZ /d 6
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /f /v MouseThreshold2 /t REG_SZ /d 10
goto :eof

:restore_AutomaticMaintenance
rem          Enable automatic maintenance
reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /f /v MaintenanceDisabled
goto :eof

:restore_UseMySignInInfo
rem          Enable "Use my sign in info after restart"
reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /f /v DisableAutomaticRestartSignOn
goto :eof

:restore_AltTab
rem          Alt tab open - Open windows and 5 most recent...
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v MultiTaskingAltTabFilter
goto :eof

:restore_SuggestWays
rem          Enable "Suggest ways to get the most out of Windows..."
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /f /v ScoobeSystemSettingEnabled
goto :eof

:restore_WindowsExperience
rem          Enable "Windows Experience ..."
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f /v SubscribedContent-310093Enabled
goto :eof

:restore_TipsAndSuggestions
rem          Enable "Get tips and suggestions when using Windows"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f /v SubscribedContent-338389Enabled /t REG_DWORD /d 00000001
goto :eof

:restore_NumLock
rem          Disable NumLock by default
reg add "HKEY_USERS\.DEFAULT\Control Panel\Keyboard" /f /v InitialKeyboardIndicators /t REG_SZ /d 2147483648
goto :eof

:restore_EaseOfAccessSettings
rem          Enable ease of access settings (Narrator + Sticky Keys)
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Ease of Access" /f /v selfvoice
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Ease of Access" /f /v selfscan
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys" /f /v Flags /t REG_SZ /d 510
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\ToggleKeys" /f /v Flags /t REG_SZ /d 62
goto :eof

:restore_CheckBoxes
rem          Disable file explorer checkboxes
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v AutoCheckSelect /t REG_DWORD /d 1
goto :eof

:restore_DifferentInputMethod
rem          Disable "Let me use a different input method for each app window"
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /f /v UserPreferencesMask /t REG_BINARY /d 9e1e078012000000
goto :eof

rem                     THIRD CHAPTER - WINGET
:wingetmenu
cls & %print% SELECT WHAT TO INSTALL: & echo.
echo: [1] C++ Redistributables        [2] 7zip                        [3] Firefox
echo: [4] Chrome                      [5] Notepad++                   [6] Discord
echo: [7] Parsec                      [8] Steam                       [9] Epic Games Launcher
echo: [10] Blender                    [11] Microsoft Teams            [12] OBS Studio
echo: [13] Zero Tier One              [14] qBittorrent                [15] Sandboxie Plus
echo: [16] JavaRE                     [17] PowerToys                  [18] KeePass
echo: [19] Zoom                       [20] VLC                        [21] Chocolatey GUI
echo: [22] AutoHotkey                 [23] Wireshark                  [24] GIMP
echo: [25] ShareX                     [26] LibreOffice                [27] Sumatra PDF
echo: [28] VirtualBox                 [29] Visual Studio Code
%print% [*] Install selected app/apps & echo [+] Check for updates & echo [0] Go back
if exist %app_list_file% echo [/] Clear list of selected apps & echo %breakline% & %print% Selected apps: & type %app_list_file% 2>nul

set "symbol=Error" & echo. & set /p symbol=ENTER THE SYMBOL: 

if "%env%"=="debug" (
for /L %%i in (1,1,30) do (
    set "symbol=%%i"
    call :app_select
    )
    call :endofthewingetfile
    goto :wingetmenu
)

:app_select
if %symbol%==+  goto :checkForUpdates
if %symbol%==*  call :endofthewingetfile
if %symbol%==/  call :startofthewingetfile
if %symbol%==0  goto :menu
if %symbol%==1  call :CPPRedist
if %symbol%==2  call :7zip
if %symbol%==3  call :Firefox
if %symbol%==4  call :Chrome
if %symbol%==5  call :NotepadPP
if %symbol%==6  call :Discord
if %symbol%==7  call :Parsec
if %symbol%==8  call :Steam
if %symbol%==9  call :EpicGamesLauncher
if %symbol%==10 call :Blender
if %symbol%==11 call :MicrosoftTeams
if %symbol%==12 call :OBSStudio
if %symbol%==13 call :ZeroTierOne
if %symbol%==14 call :qBittorrent
if %symbol%==15 call :SandboxiePlus
if %symbol%==16 call :JavaRE
if %symbol%==17 call :PowerToys
if %symbol%==18 call :KeePass
if %symbol%==19 call :Zoom
if %symbol%==20 call :VLC
if %symbol%==21 call :ChocolateyGUI
if %symbol%==22 call :AutoHotkey
if %symbol%==23 call :Wireshark
if %symbol%==24 call :GIMP
if %symbol%==25 call :ShareX
if %symbol%==26 call :LibreOffice
if %symbol%==27 call :SumatraPDF
if %symbol%==28 call :VirtualBox
if %symbol%==29 call :VisualStudioCode
if "%env%"=="debug" goto :eof
if NOT "%env%"=="debug" goto :wingetmenu

:checkForUpdates
winget upgrade --accept-source-agreements --all
pause & goto :wingetmenu

:startofthewingetfile
call :delete
echo {>> %winget_file%
echo    "$schema" : "https://aka.ms/winget-packages.schema.2.0.json",>> %winget_file%
echo    "CreationDate" : "2023-04",>> %winget_file%
echo    "Sources" : >> %winget_file%
echo    [>> %winget_file%
echo        {>> %winget_file%
echo            "Packages" : >> %winget_file%
echo            [>> %winget_file%
goto :eof

:CPPRedist
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=C++ Redistributable 2005, 2008, 2012, 2013, 2015+ added"
set wingetapp=Microsoft.VCRedist.2008.x86
call :winget_app & call :app_list_file_txt
set wingetapp=Microsoft.VCRedist.2008.x64
call :winget_app
set wingetapp=Microsoft.VCRedist.2005.x86
call :winget_app
set wingetapp=Microsoft.VCRedist.2005.x64
call :winget_app
set wingetapp=Microsoft.VCRedist.2015+.x86
call :winget_app
set wingetapp=Microsoft.VCRedist.2015+.x64
call :winget_app
set wingetapp=Microsoft.VCRedist.2012.x86
call :winget_app
set wingetapp=Microsoft.VCRedist.2012.x64
call :winget_app
set wingetapp=Microsoft.VCRedist.2013.x64
call :winget_app
set wingetapp=Microsoft.VCRedist.2013.x86
call :winget_app & goto :eof

:7zip
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=7zip added"
set wingetapp=7zip.7zip
call :winget_app & call :app_list_file_txt & goto :eof

:Firefox
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=Firefox added"
set wingetapp=Mozilla.Firefox
call :winget_app & call :app_list_file_txt & goto :eof

:Chrome
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=Chrome added"
set wingetapp=Google.Chrome
call :winget_app & call :app_list_file_txt & goto :eof

:NotepadPP
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=Notepad++ added"
set wingetapp=Notepad++.Notepad++
call :winget_app & call :app_list_file_txt & goto :eof

:Discord
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=Discord added"
set wingetapp=Discord.Discord
call :winget_app & call :app_list_file_txt & goto :eof

:Parsec
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=Parsec added"
set wingetapp=Parsec.Parsec
call :winget_app & call :app_list_file_txt & goto :eof

:Steam
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=Steam added"
set wingetapp=Valve.Steam
call :winget_app & call :app_list_file_txt & goto :eof

:EpicGamesLauncher
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=Epic Games Launcher added"
set wingetapp=EpicGames.EpicGamesLauncher
call :winget_app & call :app_list_file_txt & goto :eof

:Blender
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=Blender added"
set wingetapp=BlenderFoundation.Blender
call :winget_app & call :app_list_file_txt & goto :eof

:MicrosoftTeams
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=Microsoft Teams added"
set wingetapp=Microsoft.Teams
call :winget_app & call :app_list_file_txt & goto :eof

:OBSStudio
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=OBS Studio added"
set wingetapp=OBSProject.OBSStudio
call :winget_app & call :app_list_file_txt & goto :eof

:ZeroTierOne
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=Zero Tier One added"
call :winget_app & call :app_list_file_txt & goto :eof

:qBittorrent
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=qBittorrent added"
set wingetapp=qBittorrent.qBittorrent
call :winget_app & call :app_list_file_txt & goto :eof

:SandboxiePlus
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=Sandboxie Plus added"
set wingetapp=Sandboxie.Plus
call :winget_app & call :app_list_file_txt & goto :eof

:JavaRE
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=Java added"
set wingetapp=Oracle.JavaRuntimeEnvironment
call :winget_app & call :app_list_file_txt & goto :eof

:PowerToys
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=PowerToys added"
set wingetapp=Microsoft.PowerToys
call :winget_app & call :app_list_file_txt & goto :eof

:KeePass
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=KeePass added"
set wingetapp=DominikReichl.KeePass
call :winget_app & call :app_list_file_txt & goto :eof

:Zoom
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=Zoom added"
set wingetapp=Zoom.Zoom
call :winget_app & call :app_list_file_txt & goto :eof

:VLC
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=VLC added"
set wingetapp=VideoLAN.VLC
call :winget_app & call :app_list_file_txt & goto :eof

:ChocolateyGUI
choice /n /m "HAVE YOU ALREADY INSTALLED CHOCOLATEY? [Y/N]"
if errorlevel 2 goto :Chocolatey
if errorlevel 1 goto :ChocolateyGUIcontinue

:Chocolatey
echo LAUNCHING CHOCOLATEY INSTALLATION SCRIPT
powershell Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
goto :ChocolateyGUIcontinue

:ChocolateyGUIcontinue
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=Chocolatey GUI added"
set wingetapp=Chocolatey.ChocolateyGUI
call :winget_app & call :app_list_file_txt & goto :eof

:AutoHotkey
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=AutoHotkey added"
set wingetapp=AutoHotkey.AutoHotkey
call :winget_app & call :app_list_file_txt & goto :eof

:Wireshark
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=Wireshark added"
set wingetapp=WiresharkFoundation.Wireshark
call :winget_app & call :app_list_file_txt & goto :eof

:GIMP
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=GIMP added"
set wingetapp=GIMP.GIMP
call :winget_app & call :app_list_file_txt & goto :eof

:ShareX
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=ShareX added"
set wingetapp=ShareX.ShareX
call :winget_app & call :app_list_file_txt & goto :eof

:LibreOffice
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=LibreOffice added"
set wingetapp=TheDocumentFoundation.LibreOffice
call :winget_app & call :app_list_file_txt & goto :eof

:SumatraPDF
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=Sumatra PDF added"
set wingetapp=SumatraPDF.SumatraPDF
call :winget_app & call :app_list_file_txt & goto :eof

:VirtualBox
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=VirtualBox added"
set wingetapp=Oracle.VirtualBox
call :winget_app & call :app_list_file_txt & goto :eof

:VisualStudioCode
if not exist %winget_file% call :startofthewingetfile %mute%
set "app_added=Visual Studio Code added"
set wingetapp=Microsoft.VisualStudioCode
call :winget_app & call :app_list_file_txt & goto :eof

:endofthewingetfile
if not exist %app_list_file% goto :eof
(
    echo            ],
    echo            "SourceDetails" : {
    echo                "Argument" : "https://winget.azureedge.net/cache",
    echo                "Identifier" : "Microsoft.Winget.Source_8wekyb3d8bbwe",
    echo                "Name" : "winget",
    echo                "Type" : "Microsoft.PreIndexed.Package"
    echo            }
    echo        }
    echo    ]
    echo }
) >> %winget_file%

echo %breakline% & %print% PRESS ANY KEY TO INSTALL SELECTED APP/APPS & pause
winget import -i %winget_file% --accept-source-agreements --accept-package-agreements
pause & call :delete & goto :wingetmenu

:winget_app
findstr /i /c:"%wingetapp%" %winget_file% %mute% && goto :eof
(
    echo                {
    echo                    "PackageIdentifier" : "%wingetapp%"
    echo                },
) >> %winget_file%
goto :eof

:app_list_file_txt
if not exist %app_list_file% (
    echo %app_added%>> %app_list_file%
) else (
    findstr /i /c:"%app_added%" %app_list_file% %mute% || echo %app_added%>> %app_list_file%
) 
goto :eof

:delete
if exist %winget_file% (
    del %winget_file% %mute%
    del %app_list_file% %mute%
    rmdir /s /q %Temp%\WinGet\ %mute%
) 
goto :eof
