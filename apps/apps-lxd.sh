UTLAPPS_lxd_init(){
    UTLAPPS_lxd_env

    alias lxd-list="lxc image list"
    alias lxd-img-new="UTLAPPS_lxd_new"

}

UTLAPPS_lxd_env(){
    LXD_ROOT="${UTL3RDP_APPS}/lxd"

    #export PATH=${LXD_DIR}:${PATH}

}

UTLAPPS_lxd_new(){
    local imgName="${1}"
    if [ -z "${imgName}" ] ; then
        echo image name must be passed ; return
    fi

    lxc image copy images:/ubuntu/trusty/amd64 local: --alias=${imgName}

}
