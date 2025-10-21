# IDM-LINUX-KALI-DEBIAN
This projects intends to show how u can integrate install IDM in Kali linux or any Debian Distro by using wine.

# KALI LINUX / Ubuntu / DEBIAN IDM Installation and Browser Integration

## Automatic Installation (Not Recommended)
### Clone the project then run the install.sh script
```bash
$ git clone https://github.com/nahidn4p/IDM-LINUX-KALI-DEBIAN
$ cd IDM-LINUX-KALI-DEBIAN
$ chmod +x install.sh
$ ./install.sh
```
## Manual Install (Recommended)
## Step 1: Update Your System

 ```bash
 sudo apt update && sudo apt upgrade -y 
 ```

## Step 2: Install Wine

- First add x32 architechture
```
sudo dpkg --add-architecture i386
```
- Then Update package and install Wine
```
sudo apt update && sudo apt install wine64 wine32 -y

```
- Wine initialization and configuration (Select Windows 10 or 11 in Wine init)
```
$ sudo rm -rf ~/.wine
$ mkdir -p ~/myapp/prefix
$ export WINEARCH=win32
$ export WINEPATH=$HOME/myapp
$ wineboot --init
$ winetricks #(optional)
```
## Step 3 : Download IDM
- Go to the official IDM site using your browser:
    👉 https://www.internetdownloadmanager.com/download.html

Save the .exe file (for example idman.exe) to your **Downloads** folder.

## Step 4 : Install IDM via wine 

```
$ cd ~/Downloads
$ wine idman.exe
```
Install it as usual.
## Step 5 : RUN IDM
After install u can run idm with this command
```
wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Internet\ Download\ Manager/IDMan.exe
```
## Step 6 : Integrate with Browsers
IDM doesn’t integrate directly with Linux browsers, but you can still:

Copy download links manually and paste into IDM.

Or use a browser extensions .

### Browser Extension Method
  - Dowload this Addon (Only Chrome & Firefox)
    Link: https://add0n.com/download-by.html [FOLLOW THE INSTRUCTION TO INSTALL]
  - Now download the idman file from the repo.
  - Now run these commands
    ```
    $ sudo chmod +x idm
    $ sudo mv idm /usr/local/bin/
    $ idm [ANY DOWNLOAD LINK]
    ```
    IF IDM Launch successfully with the link u r good to go.
    
Now Try to Download supported file from ur browser and check if IDM launche Correctly  or Not.

## Creating Desktop Shortcuts

- Run this in terminal
```
  nano ~/.local/share/applications/idm.desktop
```
- Paste this code
```
[Desktop Entry]
Name=Internet Download Manager (Wine)
Comment=Launch Internet Download Manager via Wine
Exec=env WINEPREFIX="/home/riyad/myapp/prefix" wine-stable C:\\ProgramData\\Microsoft\\Windows\\Start\ Menu\\Programs\\Internet\ Download\ Manager\\Internet\ Download\ Manager.lnk
Type=Application
StartupNotify=true
Path=$HOME/myapp/prefix/drive_c/Program\ Files/Internet\ Download\ Manager/
Icon=$HOME/myapp/prefix/drive_c/Program\ Files/Internet\ Download\ Manager//idm.png
Categories=Network;Download;Wine;
```
- Make it Executable
```
chmod +x ~/.local/share/applications/idm.desktop
```
- Download Logo
```
wget https://upload.wikimedia.org/wikipedia/en/9/92/Internet_Download_Manager_logo.png
```
- Move logo and rename it
```
mv Internet_Download_Manager_logo.png idm.png && mv idm.png /home/riyad/myapp/prefix/drive_c/Program\ Files/Internet\ Download\ Manager/

```
- Refresh Desktop Icon Database
```
update-desktop-database ~/.local/share/applications/
```
- DONE

## References

- https://forum.manjaro.org/t/wine-could-not-load-kernel32-dll-status-c0000135/69811
- https://github.com/tazihad/idm-linux

