#!/usr/bin/env bash

echo "[ok] Hide dock in lower right corner." # Dock need to be running if you want exposé and spaces.
defaults write com.apple.dock autohide -boolean true
defaults write com.apple.Dock orientation -string top
defaults write com.apple.dock tilesize -int 1
defaults write com.apple.dock pinning -string end

echo "[ok] Disable spaces animation"
defaults write com.apple.dock workspaces-swoosh-animation-off -bool YES
killall Dock

echo "[ok] Maximize windows with ctrl+cmd+Z and disable cmd+Q for Terminal.app"
defaults write NSGlobalDomain NSUserKeyEquivalents '{"Quit Terminal" = "@$Q";"Zoom" = "@^Z";"Zoom Window" = "@^Z";}'

echo
echo Other configruation suggestions
echo ===============================
echo
echo "* remove spotlight icon from menubar"
echo "  http://superuser.com/questions/32593/remove-spotlight-icon-from-the-menu-bar"
echo "  also go to /System/Library/CoreServices/Menu Extras and fiddle with HomeSync is you want"
echo "  to get rid of that crap too."
echo
echo "* create a new file in current finder directory"
echo "  http://maururu.net/2007/enhanced-open-terminal-here-for-leopard/"
echo
echo "* stop itunes from automagically opening on play/pause button"
echo "  sudo chmod -x /Applications/iTunes.app"
echo "  http://discussions.apple.com/thread.jspa?threadID=2122639&start=15&tstart=0"

# Disable The Spotlight Icon
# This command removes the spotlight icon. Type 755 to re-enable it, instead of 0.
# sudo chmod 0 /System/Library/CoreServices/Spotlight.app
# killall Spotlight

# Most dialogue boxes have a cool animation effect that looks cool. If you want to
# speed this up you can change the speed at which is renders so it appears almost
# instantly. The default is 0.2.
# defaults write NSGlobalDomain NSWindowResizeTime 0.01
