#!/bin/bash
# =======================================================
# IDM Installer & Integrator for Debian / Ubuntu / Kali
# Author: NH Riyad
# GitHub: https://github.com/<your-username>/IDM-LINUX-KALI-DEBIAN
# =======================================================

set -e

echo "🚀 Starting IDM Installation & Integration for Debian-based systems..."
sleep 1

# ---------- STEP 1: UPDATE SYSTEM ----------
echo "🔄 Updating system packages..."
sudo apt update && sudo apt upgrade -y

# ---------- STEP 2: INSTALL WINE ----------
echo "🍷 Installing Wine..."
sudo dpkg --add-architecture i386
sudo apt update && sudo apt install -y wine64 wine32 winetricks wget

# ---------- STEP 3: WINE CONFIGURATION ----------
echo "⚙️ Configuring Wine environment..."
WINEPREFIX="$HOME/myapp/prefix"
export WINEARCH=win32
mkdir -p "$WINEPREFIX"
rm -rf ~/.wine || true

echo "Initializing Wine..."
wineboot --init

# ---------- STEP 4: INSTALL IDM ----------
echo "📦 Checking IDM installer..."
cd ~/Downloads
if [ ! -f "idman.exe" ]; then
    echo "⚠️ IDM installer not found!"
    echo "Please manually download IDM installer from:"
    echo "👉 https://www.internetdownloadmanager.com/download.html"
    echo "Rename the file to idman.exe and place it in your ~/Downloads folder."
    exit 1
fi

echo "📦 Installing IDM using Wine..."
wine ~/Downloads/idman.exe || echo "⚠️ If setup fails, try re-running manually: wine ~/Downloads/idman.exe"

# ---------- STEP 5: CREATE IDM LAUNCH SCRIPT ----------
echo "🧩 Creating IDM launcher command..."
if [ ! -f /usr/local/bin/idm ]; then
    sudo tee /usr/local/bin/idm > /dev/null <<EOF
#!/bin/bash
env WINEPREFIX="$HOME/myapp/prefix" wine "\$HOME/.wine/drive_c/Program Files (x86)/Internet Download Manager/IDMan.exe" "\$@"
EOF
    sudo chmod +x /usr/local/bin/idm
    echo "✅ IDM command added — now you can run 'idm' from terminal!"
else
    echo "ℹ️ 'idm' command already exists, skipping launcher creation."
fi

# ---------- STEP 6: CREATE DESKTOP SHORTCUT ----------
DESKTOP_FILE="$HOME/.local/share/applications/idm.desktop"
if [ -f "$DESKTOP_FILE" ]; then
    echo "🖥️ Desktop shortcut already exists — skipping creation."
else
    echo "🖥️ Creating desktop shortcut..."
    mkdir -p "$(dirname "$DESKTOP_FILE")"
    cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=Internet Download Manager (Wine)
Comment=Launch Internet Download Manager via Wine
Exec=env WINEPREFIX="$HOME/myapp/prefix" wine-stable C:\\\\ProgramData\\\\Microsoft\\\\Windows\\\\Start Menu\\\\Programs\\\\Internet Download Manager\\\\Internet Download Manager.lnk
Type=Application
StartupNotify=true
Path=$HOME/myapp/prefix/drive_c/Program Files/Internet Download Manager/
Icon=$HOME/myapp/prefix/drive_c/Program Files/Internet Download Manager/idm.png
Categories=Network;Download;Wine;
EOF
    chmod +x "$DESKTOP_FILE"
    echo "✅ Desktop shortcut created successfully!"
fi

# ---------- STEP 7: ADD ICON ----------
echo "🖼️ Downloading IDM icon..."
ICON_PATH="$HOME/myapp/prefix/drive_c/Program Files/Internet Download Manager/"
mkdir -p "$ICON_PATH"
if [ ! -f "$ICON_PATH/idm.png" ]; then
    wget -O "$ICON_PATH/idm.png" https://upload.wikimedia.org/wikipedia/en/9/92/Internet_Download_Manager_logo.png
else
    echo "ℹ️ IDM icon already exists, skipping download."
fi

update-desktop-database ~/.local/share/applications/ || true

# ---------- STEP 8: FINISH ----------
echo "🎉 IDM installation completed successfully!"
echo "💡 Run IDM using:  idm"
echo "💡 Or open it from your application menu as 'Internet Download Manager (Wine)'"
