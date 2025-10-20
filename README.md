# IDM-LINUX-KALI-DEBIAN
This projects intends to show how u can integrate install IDM in Kali linux or any Debian Distro by using wine.

# KALI LINUX / DEBIAN IDM Installation and Browser Integration

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

