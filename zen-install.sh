wget https://github.com/zen-browser/desktop/releases/download/1.13.2b/zen.linux-x86_64.tar.xz
sudo tar xf zen.linux-x86_64.tar.xz -C /opt
sudo ln -s /opt/zen/zen /usr/bin/zen
sudo mkdir -p /usr/local/share/applications
sudo nano /usr/local/share/applications/zen.desktop

# Where zen.desktop contains:
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
