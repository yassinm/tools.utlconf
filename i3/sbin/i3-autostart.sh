#!/bin/bash

# Desktop environment
nm-applet &
gnome-screensaver &
#gnome-keyring-daemon
gnome-settings-daemon &


#i3-battery-indicator &
#xset dpms 1800 3600 3630

#dnssec-trigger-panel &
#syncthing -no-browser &
#redshift-gtk -l manual &

xautolock -time 5 -locker "gnome-screensaver-command --lock" &
#/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

# Cleanup unnecessary files
rm -rf "$HOME/.thumbnails"
rm -rf "$HOME/.local/share/Trash"
rm -rf "$HOME/.cache/google-chrome"

# Graphical programs
#ionice -n7 akregator &