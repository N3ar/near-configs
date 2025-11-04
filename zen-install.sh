#!/bin/bash

source ./HELPERS.sh
source ./env.sh

if [[ $(is_installed flatpak) -gt 0 ]]; then
    wget https://github.com/zen-browser/desktop/releases/download/1.13.2b/zen.linux-x86_64.tar.xz
    sudo tar xf zen.linux-x86_64.tar.xz -C /opt
    sudo ln -s /opt/zen/zen /usr/bin/zen
    sudo mkdir -p /usr/local/share/applications

    ZEN_DESKTOP_FILE=/usr/local/share/applications/zen.desktop
    touch $ZEN_DESKTOP_FILE

    read -r -d '' ZEN_DESKTOP <<'EOF'
[Desktop Entry]
Version=1.0
Name=Zen Browser
Comment=Experience tranquillity while browsing the web without people tracking you!
GenericName=Web Browser
Keywords=Internet;WWW;Browser;Web;Explorer
Exec=zen
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=/opt/zen/browser/chrome/icons/default/default128.png
Categories=GNOME;GTK;KDE;Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/chrome;video/webm;application/x-xpinstall;
EOF

    # Append only if not already present
    if ! grep -q 'Name=Zen Browser' "$ZEN_DESKTOP_FILE" 2>/dev/null; then
        echo "$ZEN_DESKTOP" >> "$ZEN_DESKTOP_FILE"
        notify s "Zen Desktop file added to /usr/local/share/applications"
    else
        notify w "Zen Desktop file already exists in /usr/local/share/applications"
    fi
    
else 
    flatpak install --user app.zen_browser.zen
    flatpak update
fi
