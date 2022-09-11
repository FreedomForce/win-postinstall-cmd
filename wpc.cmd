@echo off
mode con: cols=145 lines=30
title win-postinstall-cmd
cd /d %~dp0
set "breakline=__________________________________________________________________________________________"
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
if %number%==4 goto :disable_passwordExp
if %number%==5 goto :open_oldMixer
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

:disable_passwordExp
echo. & wmic UserAccount where "Name='%username%'" set PasswordExpires=False
pause & goto :tweaks

:open_oldMixer
sndvol.exe
goto :tweaks

rem                     SECOND CHAPTER - REGISTRY KEYS
:registry
cls & %print% SELECT YOUR TASK: & echo.
echo: [11] Remove chat from taskbar                             [21] Remove Cortana from taskbar 
echo: [12] Remove task view from taskbar                        [22] Remove search from taskbar
echo: [13] Remove meet now                                      [23] Remove news and interests
echo: [14] Remove taskbar pins                                  [24] Remove Widgets from the Taskbar
echo: [15] Always hide most used list in start menu             [25] Disable show recently added apps
echo: [16] Disable "Show recently opened items in Start..."     [26] Enable Compact Mode
echo: [17] Open file explorer to - This PC                      [27] Show file name extensions
echo: [18] Sound communications - do nothing                    [28] Disable startup sound 
echo: [19] Turn off enhance pointer precision                   [29] Disable automatic maintenance
echo: [101] Disable "Use my sign in info after restart"         [201] Alt tab - open windows only
echo: [102] Restore the classic context menu                    [202] Disable "Suggest ways to get the most out of Windows..."
echo: [103] Disable "Windows Experience ..."                    [203] Disable "Get tips and suggestions when using Windows"
echo: [104] Enable NumLock by default                           [204] Disable ease of access settings (Narrator + Sticky Keys)
echo: [105] Enable file explorer checkboxes                     [205] Enable "Let me use a different input method for each app window"
%print% [0] GO BACK & echo [*] SELECT ALL & echo [/] RESTORE SETTINGS

set "symbol=Error" & echo. & set /p symbol=ENTER THE SYMBOL: 
if %symbol%==/   goto :registry_restore
if %symbol%==*   goto :registry_all_keys
if %symbol%==0   call :menu
if %symbol%==11  call :import_chat                       >nul 2>&1
if %symbol%==21  call :import_cortana_icon               >nul 2>&1
if %symbol%==12  call :import_TaskView_icon              >nul 2>&1
if %symbol%==22  call :import_search_icon                >nul 2>&1
if %symbol%==13  call :import_meet_icon                  >nul 2>&1
if %symbol%==23  call :import_NewsAndInterests_icon      >nul 2>&1
if %symbol%==14  call :import_TaskbarPins                >nul 2>&1
if %symbol%==24  call :import_WidgetsFromTheTaskbar_icon >nul 2>&1
if %symbol%==15  call :import_MostUsedList               >nul 2>&1
if %symbol%==25  call :import_ShowRecentlyAddedApps      >nul 2>&1
if %symbol%==16  call :import_ShowRecentlyOpened         >nul 2>&1
if %symbol%==26  call :import_CompactMode                >nul 2>&1
if %symbol%==17  call :import_OpenFileExplorer           >nul 2>&1
if %symbol%==27  call :import_FileNameExtensions         >nul 2>&1
if %symbol%==18  call :import_SoundCommunications        >nul 2>&1
if %symbol%==28  call :import_StartupSound               >nul 2>&1
if %symbol%==19  call :import_EnhancePointerPrecision    >nul 2>&1
if %symbol%==29  call :import_AutomaticMaintenance       >nul 2>&1
if %symbol%==101 call :import_UseMySignInInfo            >nul 2>&1
if %symbol%==201 call :import_AltTab                     >nul 2>&1
if %symbol%==102 call :import_ClassicContextMenu         >nul 2>&1
if %symbol%==202 call :import_SuggestWays                >nul 2>&1
if %symbol%==103 call :import_WindowsExperience          >nul 2>&1
if %symbol%==203 call :import_TipsAndSuggestions         >nul 2>&1
if %symbol%==104 call :import_NumLock                    >nul 2>&1
if %symbol%==204 call :import_EaseOfAccessSettings       >nul 2>&1
if %symbol%==105 call :import_CheckBoxes                 >nul 2>&1
if %symbol%==205 call :import_DifferentInputMethod       >nul 2>&1
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
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /f /v EnableFeeds /t REG_DWORD /d 00000000
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
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /f /v ShowOrHideMostUsedApps /t REG_DWORD /d 00000002
goto :eof

:import_ShowRecentlyAddedApps
rem          Disable show recently added apps
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /f /v HideRecentlyAddedApps /t REG_DWORD /d 00000001
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v HideRecentlyAddedApps /t REG_DWORD /d 00000001
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
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /f /v MaintenanceDisabled /t REG_DWORD /d 00000001
goto :eof

:import_UseMySignInInfo
rem          Disable use my sign in info after restart
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /f /v DisableAutomaticRestartSignOn /t REG_DWORD /d 00000001
goto :eof

:import_AltTab
rem          Alt tab open windows only
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v MultiTaskingAltTabFilter /t REG_DWORD /d 00000003
goto :eof

:import_ClassicContextMenu
rem          Restore the classic context menu
reg add "HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
goto :eof

:import_SuggestWays
rem          Disable "Suggest ways to get the most out of Windows and finish setting up this device"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /f /v ScoobeSystemSettingEnabled /t REG_DWORD /d 00000000
goto :eof

:import_WindowsExperience
rem          Disable "Windows Experience..."
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f /v SubscribedContent-310093Enabled /t REG_DWORD /d 00000000
goto :eof

:import_TipsAndSuggestions
rem          Disable "Get tips and suggestions when using Windows"
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f /v SubscribedContent-338389Enabled /t REG_DWORD /d 00000000
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
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v AutoCheckSelect /t REG_DWORD /d 1
goto :eof

:import_DifferentInputMethod
rem          Let me use a different input method for each app window
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /f /v UserPreferencesMask /t REG_BINARY /d 9e1e068092000000
goto :eof

:registry_all_keys
call :import_chat                       >nul 2>&1
call :import_cortana_icon               >nul 2>&1
call :import_TaskView_icon              >nul 2>&1
call :import_search_icon                >nul 2>&1
call :import_meet_icon                  >nul 2>&1
call :import_NewsAndInterests_icon      >nul 2>&1
call :import_TaskbarPins                >nul 2>&1
call :import_WidgetsFromTheTaskbar_icon >nul 2>&1
call :import_MostUsedList               >nul 2>&1
call :import_ShowRecentlyAddedApps      >nul 2>&1
call :import_ShowRecentlyOpened         >nul 2>&1
call :import_CompactMode                >nul 2>&1
call :import_OpenFileExplorer           >nul 2>&1
call :import_FileNameExtensions         >nul 2>&1
call :import_SoundCommunications        >nul 2>&1
call :import_StartupSound               >nul 2>&1
call :import_EnhancePointerPrecision    >nul 2>&1
call :import_AutomaticMaintenance       >nul 2>&1
call :import_UseMySignInInfo            >nul 2>&1
call :import_AltTab                     >nul 2>&1
call :import_ClassicContextMenu         >nul 2>&1
call :import_SuggestWays                >nul 2>&1
call :import_WindowsExperience          >nul 2>&1
call :import_TipsAndSuggestions         >nul 2>&1
call :import_NumLock                    >nul 2>&1
call :import_EaseOfAccessSettings       >nul 2>&1
call :import_CheckBoxes                 >nul 2>&1
call :import_DifferentInputMethod       >nul 2>&1
goto :registry

:registry_restore
cls & %print% SELECT YOUR TASK: & echo.
echo: [11] Restore chat on taskbar                                               [21] Restore Cortana on taskbar 
echo: [12] Restore task view on taskbar                                          [22] Restore search on taskbar
echo: [13] Restore meet now                                                      [23] Restore news and interests
echo: [14] Restore Widgets on the Taskbar                                        [24] Disable "Always hide most used list in start menu"
echo: [15] Enable show recently added apps                                       [25] Enable "Show recently opened items in Start..."
echo: [16] Disable Compact Mode                                                  [26] Open file explorer to - Quick access
echo: [17] Disable Show file name extensions                                     [27] Restore Sound communications tab
echo: [18] Enable startup sound                                                  [28] Restore enhance pointer precision
echo: [19] Enable automatic maintenance                                          [29] Enable "Use my sign in info after restart"
echo: [101] Alt tab open - Open windows and 5 most recent...                     [201] Disable the classic context menu
echo: [102] Enable "Suggest ways to get the most out of Windows..."              [202] Enable "Windows Experience ..."
echo: [103] Enable "Get tips and suggestions when using Windows"                 [203] Disable NumLock by default
echo: [104] Enable ease of access settings (Narrator + Sticky Keys)              [204] Disable file explorer checkboxes
echo: [105] Disable "Let me use a different input method for each app window"
%print% [0] GO BACK & echo [*] SELECT ALL

set "symbol=Error" & echo. & set /p symbol=ENTER THE SYMBOL: 
if %symbol%==*   goto :registry_restore_all_keys
if %symbol%==0   goto :registry
if %symbol%==11  call :restore_chat                       >nul 2>&1
if %symbol%==21  call :restore_cortana_icon               >nul 2>&1
if %symbol%==12  call :restore_TaskView_icon              >nul 2>&1
if %symbol%==22  call :restore_search_icon                >nul 2>&1
if %symbol%==13  call :restore_meet_icon                  >nul 2>&1
if %symbol%==23  call :restore_NewsAndInterests_icon      >nul 2>&1
if %symbol%==14  call :restore_WidgetsFromTheTaskbar_icon >nul 2>&1
if %symbol%==24  call :restore_MostUsedList               >nul 2>&1
if %symbol%==15  call :restore_ShowRecentlyAddedApps      >nul 2>&1
if %symbol%==25  call :restore_ShowRecentlyOpened         >nul 2>&1
if %symbol%==16  call :restore_CompactMode                >nul 2>&1
if %symbol%==26  call :restore_OpenFileExplorer           >nul 2>&1
if %symbol%==17  call :restore_FileNameExtensions         >nul 2>&1
if %symbol%==27  call :restore_SoundCommunications        >nul 2>&1
if %symbol%==18  call :restore_StartupSound               >nul 2>&1
if %symbol%==28  call :restore_EnhancePointerPrecision    >nul 2>&1
if %symbol%==19  call :restore_AutomaticMaintenance       >nul 2>&1
if %symbol%==29  call :restore_UseMySignInInfo            >nul 2>&1
if %symbol%==101 call :restore_AltTab                     >nul 2>&1
if %symbol%==201 call :restore_ClassicContextMenu         >nul 2>&1
if %symbol%==102 call :restore_SuggestWays                >nul 2>&1
if %symbol%==202 call :restore_WindowsExperience          >nul 2>&1
if %symbol%==103 call :restore_TipsAndSuggestions         >nul 2>&1
if %symbol%==203 call :restore_NumLock                    >nul 2>&1
if %symbol%==104 call :restore_EaseOfAccessSettings       >nul 2>&1
if %symbol%==204 call :restore_CheckBoxes                 >nul 2>&1
if %symbol%==105 call :restore_DifferentInputMethod       >nul 2>&1
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
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /f /v EnableFeeds
goto :eof

:restore_WidgetsFromTheTaskbar_icon
rem          Remove Widgets from the Taskbar
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v TaskbarDa
goto :eof

:restore_MostUsedList
rem          Disable "Always hide most used list in start menu"
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /f /v ShowOrHideMostUsedApps
goto :eof

:restore_ShowRecentlyAddedApps
rem          Enable show recently added apps
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /f /v HideRecentlyAddedApps
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v HideRecentlyAddedApps
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
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /f /v MaintenanceDisabled
goto :eof

:restore_UseMySignInInfo
rem          Enable "Use my sign in info after restart"
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /f /v DisableAutomaticRestartSignOn
goto :eof

:restore_AltTab
rem          Alt tab open - Open windows and 5 most recent...
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v MultiTaskingAltTabFilter
goto :eof

:restore_ClassicContextMenu
rem          Disable the classic context menu
reg delete "HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
goto :eof

:restore_SuggestWays
rem          Enable "Suggest ways to get the most out of Windows..."
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /f /v ScoobeSystemSettingEnabled
goto :eof

:restore_WindowsExperience
rem          Enable "Windows Experience ..."
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f /v SubscribedContent-310093Enabled
goto :eof

:restore_TipsAndSuggestions
rem          Enable "Get tips and suggestions when using Windows"
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /f /v SubscribedContent-338389Enabled /t REG_DWORD /d 00000001
goto :eof

:restore_NumLock
rem          Disable NumLock by default
reg add "HKEY_USERS\.DEFAULT\Control Panel\Keyboard" /f /v InitialKeyboardIndicators /t REG_SZ /d 2147483648
goto :eof

:restore_EaseOfAccessSettings
rem          Enable ease of access settings (Narrator + Sticky Keys)
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Ease of Access" /f /ve
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys" /f /v Flags /t REG_SZ /d 510
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\ToggleKeys" /f /v Flags /t REG_SZ /d 62
goto :eof

:restore_CheckBoxes
rem          Disable file explorer checkboxes
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v AutoCheckSelect /t REG_DWORD /d 1
goto :eof

:restore_DifferentInputMethod
rem          Disable "Let me use a different input method for each app window"
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /f /v UserPreferencesMask /t REG_BINARY /d 9e1e078012000000
goto :eof

:registry_restore_all_keys
call :restore_chat                       >nul 2>&1
call :restore_cortana_icon               >nul 2>&1
call :restore_TaskView_icon              >nul 2>&1
call :restore_search_icon                >nul 2>&1
call :restore_meet_icon                  >nul 2>&1
call :restore_NewsAndInterests_icon      >nul 2>&1
call :restore_WidgetsFromTheTaskbar_icon >nul 2>&1
call :restore_MostUsedList               >nul 2>&1
call :restore_ShowRecentlyAddedApps      >nul 2>&1
call :restore_ShowRecentlyOpened         >nul 2>&1
call :restore_CompactMode                >nul 2>&1
call :restore_OpenFileExplorer           >nul 2>&1
call :restore_FileNameExtensions         >nul 2>&1
call :restore_SoundCommunications        >nul 2>&1
call :restore_StartupSound               >nul 2>&1
call :restore_EnhancePointerPrecision    >nul 2>&1
call :restore_AutomaticMaintenance       >nul 2>&1
call :restore_UseMySignInInfo            >nul 2>&1
call :restore_AltTab                     >nul 2>&1
call :restore_ClassicContextMenu         >nul 2>&1
call :restore_SuggestWays                >nul 2>&1
call :restore_WindowsExperience          >nul 2>&1
call :restore_TipsAndSuggestions         >nul 2>&1
call :restore_NumLock                    >nul 2>&1
call :restore_EaseOfAccessSettings       >nul 2>&1
call :restore_CheckBoxes                 >nul 2>&1
call :restore_DifferentInputMethod       >nul 2>&1
goto :registry_restore

rem                     THIRD CHAPTER - WINGET
:winget
goto :startofthewingetfile

:wingetmenu
cls & %print% SELECT WHAT TO INSTALL: & echo.
echo: [1] C++ Redistributables        [2] 7zip                        [3] Firefox (ESR)
echo: [4] Chrome                      [5] Notepad++                   [6] Discord
echo: [7] Parsec                      [8] Steam                       [9] Epic Games Launcher
echo: [10] Ubisoft Connect            [11] Microsoft Teams            [12] OBS Studio
echo: [13] Zero Tier One              [14] qBittorrent                [15] Sandboxie Plus
echo: [16] Viber                      [17] Java                       [18] PowerToys
echo: [19] KeePass                    [20] Malwarebytes               [21] Zoom
echo: [22] VLC                        [23] Cloudflare Warp            [24] Chocolatey GUI
echo: [25] .NET Framework             [26] AutoHotkey                 [27] Wireshark
echo: [28] GIMP                       [29] ShareX
%print% [*] CREATE FILE & echo [0] GO BACK
if exist selected-apps.txt echo [/] CLEAR LIST OF SELECTED APPS & echo %breakline% & %print% SELECTED APPS: & type selected-apps.txt 2>nul

set "symbol=Error" & echo. & set /p symbol=ENTER THE SYMBOL: 
if %symbol%==*  goto :endofthewingetfile
if %symbol%==/  call :delete & goto :startofthewingetfile
if %symbol%==0  goto :menu
if %symbol%==1  goto :C++Redist
if %symbol%==2  goto :7zip
if %symbol%==3  goto :FirefoxESR
if %symbol%==4  goto :Chrome
if %symbol%==5  goto :Notepad++
if %symbol%==6  goto :Discord
if %symbol%==7  goto :Parsec
if %symbol%==8  goto :Steam
if %symbol%==9  goto :EpicGamesLauncher
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
if %symbol%==26 goto :AutoHotkey
if %symbol%==27 goto :Wireshark
if %symbol%==28 goto :GIMP
if %symbol%==29 goto :ShareX
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
set "app_added=C++ Redistributable added"
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
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
call :winget_app & goto :wingetmenu

:7zip
set "app_added=7zip added"
set wingetapp=7zip.7zip
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:FirefoxESR
set "app_added=Firefox (ESR) added"
set wingetapp=Mozilla.Firefox.ESR
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:Chrome
set "app_added=Chrome added"
set wingetapp=Google.Chrome
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:Notepad++
set "app_added=Notepad++ added"
set wingetapp=Notepad++.Notepad++
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:Discord
set "app_added=Discord added"
set wingetapp=Discord.Discord
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:Parsec
set "app_added=Parsec added"
set wingetapp=Parsec.Parsec
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:Steam
set "app_added=Steam added"
set wingetapp=Valve.Steam
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:EpicGamesLauncher
set "app_added=Epic Games Launcher added"
set wingetapp=EpicGames.EpicGamesLauncher
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:Ubisoft
set "app_added=Ubisoft Connect added"
set wingetapp=Ubisoft.Connect
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:MicrosoftTeams
set "app_added=Microsoft Teams added"
set wingetapp=Microsoft.Teams
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:OBSStudio
set "app_added=OBS Studio added"
set wingetapp=OBSProject.OBSStudio
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:ZeroTierOne
set "app_added=Zero Tier One added"
set wingetapp=ZeroTier.ZeroTierOne
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:qBittorrent
set "app_added=qBittorrent added"
set wingetapp=qBittorrent.qBittorrent
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:SandboxiePlus
set "app_added=Sandboxie Plus added"
set wingetapp=Sandboxie.Plus
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:Viber
set "app_added=Viber added"
set wingetapp=Viber.Viber
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:Java
set "app_added=Java added"
set wingetapp=Oracle.JavaRuntimeEnvironment
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:PowerToys
set "app_added=PowerToys added"
set wingetapp=Microsoft.PowerToys
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:KeePass
set "app_added=KeePass added"
set wingetapp=DominikReichl.KeePass
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:Malwarebytes
set "app_added=Malwarebytes added"
set wingetapp=Malwarebytes.Malwarebytes
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:Zoom
set "app_added=Zoom added"
set wingetapp=Zoom.Zoom
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:VLC
set "app_added=VLC added"
set wingetapp=VideoLAN.VLC
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:CloudflareWarp
set "app_added=Cloudflare Warp added"
set wingetapp=Cloudflare.Warp
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:ChocolateyGUI
choice /n /m "HAVE YOU ALREADY INSTALLED CHOCOLATEY? [Y/N]"
if errorlevel 2 goto :Chocolatey
if errorlevel 1 goto :ChocolateyGUIcontinue

:Chocolatey
echo LAUNCHING CHOCOLATEY INSTALLATION SCRIPT
powershell Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) 
goto :ChocolateyGUIcontinue

:ChocolateyGUIcontinue
set "app_added=Chocolatey GUI added"
set wingetapp=Chocolatey.ChocolateyGUI
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:dotNetFramework
set "app_added=.NET Framework added"
set wingetapp=Microsoft.dotNetFramework
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:AutoHotkey
set "app_added=AutoHotkey added"
set wingetapp=Lexikos.AutoHotkey
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:Wireshark
set "app_added=Wireshark added"
set wingetapp=WiresharkFoundation.Wireshark
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:GIMP
set "app_added=GIMP added"
set wingetapp=GIMP.GIMP
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

:ShareX
set "app_added=ShareX added"
set wingetapp=ShareX.ShareX
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :wingetmenu
call :winget_app & goto :wingetmenu

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
if not exist selected-apps.txt echo %app_added%>> selected-apps.txt
if exist selected-apps.txt find /c "%app_added%" selected-apps.txt >nul 2>&1 && goto :eof || echo %app_added%>> selected-apps.txt
goto :eof

:delete
if exist winget.json del winget.json >nul 2>&1 & del selected-apps.txt >nul 2>&1 & rmdir /s /q %Temp%\WinGet\ >nul 2>&1
goto :eof
