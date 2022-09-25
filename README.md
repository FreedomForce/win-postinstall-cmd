# win-postinstall-cmd
The main goal of this script is to save you time and automate routine after a fresh install of Windows.

It is a .CMD file that executes pre-defined commands, creates files, imports lines in files, applies registry keys, and installs applications using winget.

# Guide
**This is the main menu of the script.**
![image](https://user-images.githubusercontent.com/78738795/189695660-17971db7-092d-4dc8-a67c-d2dcd02972c7.png)

**First of all, you need to check winget for updates. To do this, please select the first option "TWEAKS" in the main menu.**
![image](https://user-images.githubusercontent.com/78738795/189696689-a67c00f4-117d-4e81-896d-36fc3d99ecc7.png)
Then enter the "1" to select "CHECK IF WINGET IS INSTALLED". The update process will start up automatically. In case of any malfunction, repeat the previous step.
If you do not have [App Installer](https://www.microsoft.com/store/productId/9NBLGGH4NNS1) (https://www.microsoft.com/store/productId/9NBLGGH4NNS1) consider to install it, you need it to install applications using this script. 
###### (Optionally) Alternatively, you can use Chocolatey as a package manager and install applications using the terminal on your own (you can install it in the "INSTALL APPLICATIONS" option by selecting "Chocolatey GUI", it will ask you if you want to install Chocolatey.)
- Here you can "CHECK FOR UPDATES". The update process will start up automatically. In case of any malfunction, repeat the previous step.
- Here you can "DISABLE HIBERNATE" (Recommended). This will turn off fast startup and hibernate.
- Here you can "DISABLE PASSWORD EXPIRATION" (Recommended). Select this in case you install Windows using Unattended.xml or you simply need to disable password expiration.
- Here you can "OPEN OLD MIXER". If you need to pin an older mixer to the taskbar on your Windows 11.

**Select the second option "IMPORT SETTINGS" in the main menu if you need to quickly import user settings after a fresh installation. In case you need to revert the imported setting to the default value select "[/] RESTORE SETTINGS"**
![image](https://user-images.githubusercontent.com/78738795/192158896-38f3d5b6-b569-4a76-9b5f-6200f41036b7.png)

**Select the third option "INSTALL APPLICATIONS" in the main menu if you need to install an application or applications from a pre-defined list.**
![image](https://user-images.githubusercontent.com/78738795/192158919-3e9b790c-4f41-4f71-b434-2a873bbbbd60.png)
