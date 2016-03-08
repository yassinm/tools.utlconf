#!/bin/sh
lock_i3() {
    i3lock
}

lock_dpms(){
   xset dpms force off
}

lock_screen() {
   lock_gnome
}

#gsettings set org.gnome.desktop.session idle-delay 60
#gsettings set org.gnome.desktop.screensaver lock-enabled true

lock_gnome_dbus(){
   dbus-send --type=method_call --dest=org.gnome.ScreenSaver \
       /org/gnome/ScreenSaver org.gnome.ScreenSaver.Lock
}

lock_gnome_screensaver(){
   gnome-screensaver-command --lock
}

lock_suspend(){
   dbus-send --system --print-reply \
       --dest="org.freedesktop.UPower" \
       /org/freedesktop/UPower \
       org.freedesktop.UPower.Suspend
}

lock_hibernate(){
   dbus-send --system --print-reply \
       --dest="org.freedesktop.UPower" \
       /org/freedesktop/UPower \
       org.freedesktop.UPower.Hibernate
}

case "$1" in
    logout)
        i3-msg exit
        ;;
    suspend)
        lock_suspend
        ;;
    reboot)
        systemctl reboot
        ;;
    shutdown)
        systemctl poweroff
        ;;
    lock)
        lock_gnome_screensaver
        ;;
    hibernate)
        lock_now && systemctl hibernate
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|hibernate|reboot|shutdown}"
        exit 2
esac

exit 0
