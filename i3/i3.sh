#hehe

UTLI3_init(){
    #echo UTLI3_init

    UTLI3_env


    alias i3-conf='UTLI3_conf'
    alias i3-conf-screen='UTLI3_screen'

    #set -x
    export PATH="${I3CFG_SBIN}:${I3CFG_APPS}:${PATH}"
    #set +x

}

UTLI3_screen(){
    (xrandr | grep -qE "connected.*1920x1080") && xrandr --output DVI-I-1 --mode 1920x1080 --primary
    (xrandr | grep -qE "connected.*2560x1080") && xrandr --output HDMI-0 --mode 2560x1080 --primary --right-of DVI-I-1
}

UTLI3_conf(){

  (
    set -ex

    UTLI3_env

    mkdir -p ${I3CFG_TMP}
    mkdir -p ${I3CFG_BIN}
    mkdir -p ${I3CFG_APPS}
    mkdir -p ${I3CFG_LOGS}
    mkdir -p ${I3CFG_LAYOUT}

    #has to be after dir created
    UTLI3_files

    #copy vnc startup
    cp ${I3CFG_XSTARTUP} ${HOME}/.vnc/xstartup

    #copy xmodmap from ubuntu
    #cp ${I3CFG_CONF}/xmodmap ${I3CFG_XMODMAP}

    cp ${I3CFG_CONF}/config.all ${I3CFG_FILE}
    cat ${I3CFG_CONF}/config.loc >> ${I3CFG_FILE}

    cp ${I3CFG_CONF}/config.all ${I3CFG_FILE}.vnc
    cat ${I3CFG_CONF}/config.vnc >> ${I3CFG_FILE}.vnc

  )

}

UTLI3_env(){
    UTLI3_DIR="${UTLCONF}/i3"
    I3CFG_SBIN="${UTLI3_DIR}/sbin"
    I3CFG_CONF="${UTLI3_DIR}/conf"

    I3CFG_DIR="${HOME}/.config/i3"
    I3CFG_FILE="${I3CFG_DIR}/config"

    I3CFG_BIN="${I3CFG_DIR}/bin"
    I3CFG_TMP="${I3CFG_DIR}/tmp"
    I3CFG_APPS="${I3CFG_DIR}/apps"
    I3CFG_LOGS="${I3CFG_DIR}/logs"
    I3CFG_LAYOUT="${I3CFG_DIR}/layout"

    I3CFG_XMODMAP="${I3CFG_TMP}/xmodmap"
    I3CFG_XSTARTUP="${I3CFG_TMP}/xstartup"

    I3CFG_XSESSION_SRC="${HOME}/.xsessionrc"
    I3CFG_XSESSION_RC="${I3CFG_TMP}/xsession.rc"
    I3CFG_XSESSION_AWK="${I3CFG_TMP}/xsession.awk"
    I3CFG_XSESSION_APPEND="${I3CFG_TMP}/xsession.append"

}

UTLI3_files(){
  UTLAPPS_vnc_env

echo creating "${I3CFG_XSESSION_RC}"
cat <<E_O_F> "${I3CFG_XSESSION_RC}"
export LC_COLLATE=POSIX
export PATH=${I3CFG_BIN}:\${PATH}
E_O_F

#run xev to find out !!!
echo creating "${I3CFG_XMODMAP}"
cat << E_O_F > ${I3CFG_XMODMAP}
add mod4    =    Super_L  Hyper_L
E_O_F

echo creating "${I3CFG_XSTARTUP}"
cat << E_O_F > ${I3CFG_XSTARTUP}
#!/bin/bash
i3startupEnv(){
  set -xe
}

i3startupV1(){
  xrdb /home/ymo/.Xresources
  xsetroot -solid grey
  export XKL_XMODMAP_DISABLE=1
  /etc/X11/Xsession
  # i3 &
  #exec i3 -c /home/ymo/.config/i3/config.vnc
  exec i3 -c /home/ymo/.config/i3/config.vnc -V -d all > "/home/ymo/.config/i3/logs/i3.log" 2>&1
}

i3startupV2(){
  i3startupEnv

  xsetroot -solid grey
  export XKL_XMODMAP_DISABLE=1

  [ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
  [ -r /home/ymo/.Xresources ] && xrdb /home/ymo/.Xresources

  /home/ymo/3rdp/apps/tigervnc/tigervnc-latest/usr/bin/vncconfig -iconic -nowin -display \${DISPLAY} &

  echo "\${DISPLAY}" > /home/ymo/.config/i3/logs/xstartup.log

  #exec i3 -c /home/ymo/.config/i3/config.vnc
  exec i3 -c /home/ymo/.config/i3/config.vnc -V -d all > "/home/ymo/.config/i3/logs/i3.log" 2>&1
}

i3startupV2
E_O_F

echo creating "${I3CFG_XSESSION_APPEND}"
cat << E_O_F > ${I3CFG_XSESSION_APPEND}
#I3UTLI3_UTLAPPS_START
source ${I3CFG_XSESSION_RC}
#I3UTLI3_UTLAPPS_END
E_O_F


}
