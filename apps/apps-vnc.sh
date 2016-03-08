UTLAPPS_vnc_init(){
    alias vnc-env='UTLAPPS_vnc_env'

    alias vnc-kill='vncserver -kill'
    alias vnc-alias='alias | grep vnc'
    alias vnc-list='ps -eo pid,user,args | grep vnc'

    alias vnc-config='vncconfig -nowin &' #must start vnc config to enable copy & paste

    alias vnc-1366='vncserver -name 1366 -geometry 1366x768'
    alias vnc-1600='vncserver -name 1600 -geometry 1600x900'
    alias vnc-1920='vncserver -name 1920 -geometry 1920x1080'
    alias vnc-2560='vncserver -name 2560 -geometry 2560x1440'

    alias vnc-home-1920='vncserver -name h.1920 -geometry 1920x1080'
    alias vnc-home-2560='vncserver -name h.2560 -geometry 2560x1080'

    alias vnc-view-1920='vncviewer 192.168.0.104:5901' #1920x1080
    alias vnc-view-2560='vncviewer 192.168.0.104:5902' #2560x1080

    alias vnc-mac-1440='vncserver -name m1440 -geometry 1440x900'
}

UTLAPPS_vnc_env(){
    VNC_ROOT="${UTL3RDP_APPS}/tigervnc"

    TIGERVNC_VER="tigervnc-latest"
    TIGERVNC_DIR="${VNC_ROOT}/${TIGERVNC_VER}"

    export PATH=${TIGERVNC_DIR}/usr/bin:${PATH}

}
