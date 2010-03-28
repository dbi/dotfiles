#!/usr/bin/env bash

# Hide dock in lower right corner. Dock need to be running if you want exposé and spaces.
defaults write com.apple.dock autohide -boolean true
defaults write com.apple.Dock orientation -string top
defaults write com.apple.dock tilesize -int 1
defaults write com.apple.dock pinning -string end
killall Dock

# Maximize windows with ctrl+cmd+Z
# http://tomafro.net/2009/11/zoom-keyboard-shortcut-for-os-x
defaults write NSGlobalDomain NSUserKeyEquivalents '{"Zoom" = "@^Z"; "Zoom Window" = "@^Z"; }'
