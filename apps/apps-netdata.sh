UTLAPPS_netdata_init(){
    alias netdata-run="UTLAPPS_netdata_run"
}

UTLAPPS_netdata_env(){
    UTLAPPS_NETDATA_VER="netdata-latest.dist"
    UTLAPPS_NETDATA_ROOT="${UTL3RDP_GITHUB}/netdata"
}

UTLAPPS_netdata_run(){
  (
    #set -x
    UTLAPPS_netdata_env
    local lDir="${UTLAPPS_NETDATA_ROOT}/${UTLAPPS_NETDATA_VER}"
    ${lDir}/netdata/usr/sbin/netdata ${@}
  )
}
