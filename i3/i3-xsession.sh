#https://github.com/ivyl/i3-config
#https://wiki.ubuntu.com/CustomXSession

#http://blog.hugochinchilla.net/2013/03/using-gnome-3-with-i3-window-manager/

UTLI3_xsession_init(){
    alias i3-conf-xsession='UTLI3_xsession_conf'

}

UTLI3_xsession_conf(){
    UTLI3_xsession_files

    #can set it to true
    gsettings set org.gnome.desktop.background show-desktop-icons false

}

UTLI3_xsession_files(){
    local i3desktop="${I3CFG_TMP}/gnome-i3.desktop"
    local i3xsession="${I3CFG_TMP}/gnome-i3.session"

    echo creating "${i3xsession}"
cat <<E_O_F> "${i3xsession}"
Name=gnome-i3
RequiredComponents=gnome-settings-daemon;gnome-panel;i3;
E_O_F

    echo creating "${i3desktop}"
cat <<E_O_F> "${i3desktop}"
[Desktop Entry]
Icon=
Type=Application
Name=GNOME with i3
TryExec=gnome-session
Exec=gnome-session --session=i3
Comment=A GNOME fallback mode session using i3 as the window manager.
E_O_F

    echo cp "${i3desktop}" /usr/share/xsessions/gnome-i3.desktop
    echo cp "${i3xsession}" /usr/share/gnome-session/sessions/i3.session
}
