UTLAPPS_pycharm_init(){
    UTLAPPS_pycharm_env

    alias pycharm-conf="UTLAPPS_pycharm_all"
    alias pycharm-latest="${PYCHARM_ROOT}/${PYCHARM_LATEST}/bin/pycharm.sh &"
}

UTLAPPS_pycharm_all(){
    UTLAPPS_pycharm_conf $PYCHARM_LATEST
}

UTLAPPS_pycharm_env(){
    #set -x

    PYCHARM_CFG=".IdeaIC"
    PYCHARM_ROOT="${UTL3RDP_DEV}/pycharm"

    # PYCHARM_LATEST="pycharm-community-2016.2.3"
    PYCHARM_LATEST="pycharm-community-2016.3"

    #set +x
}

UTLAPPS_pycharm_conf(){
    set -x

    UTLAPPS_pycharm_env

    local lVersion="${1}"
    #local lVersion="${lDir##*/}"

    if [ -z "${lVersion}" ] ; then
        echo much pass version for configurations; return
    fi

    local lDir="${PYCHARM_ROOT}/${lVersion}"
    if ! [ -e "${lDir}" ] ; then
        echo "missing dir ${lDir}"  ; return
    fi

    local dname_pycharm="${PYCHARM_ROOT}/${lVersion}"
    local dname_conf="${PYCHARM_ROOT}/conf/conf-${lVersion}"

    local sedfile="${dname_conf}/${lVersion}.sed"
    local properties="${dname_pycharm}/bin/idea.properties"
    local vmoptions="${dname_pycharm}/bin/pycharm64.vmoptions"

    mkdir -p ${dname_conf}
    mkdir -p ${dname_pycharm}/${PYCHARM_CFG}/config/codestyles
    mkdir -p ${dname_pycharm}/${PYCHARM_CFG}/config/inspection

    if ! [ -e ${vmoptions}.000 ] ; then
        cp ${vmoptions} ${vmoptions}.000
    fi

    if ! [ -e ${properties}.000 ] ; then
        cp ${properties} ${properties}.000
    fi

   cat <<E_O_F>${sedfile}
s@^.*pycharm.log.path=.*@pycharm.log.path=\${pycharm.home.path}/${PYCHARM_CFG}/system/log@g
s@^.*pycharm.config.path=.*@pycharm.config.path=\${pycharm.home.path}/${PYCHARM_CFG}/config@g
s@^.*pycharm.system.path=.*@pycharm.system.path=\${pycharm.home.path}/${PYCHARM_CFG}/system@g
s@^.*pycharm.plugins.path=.*@pycharm.plugins.path=\${pycharm.home.path}/${PYCHARM_CFG}/config/plugins@g
E_O_F

   cat <<"E_O_F"> ${vmoptions}
-Xms1024m
-Xmx1200m
-XX:ReservedCodeCacheSize=240m
-XX:+UseConcMarkSweepGC
-XX:SoftRefLRUPolicyMSPerMB=50
-ea
-Dsun.io.useCanonCaches=false
-Djava.net.preferIPv4Stack=true
-XX:+HeapDumpOnOutOfMemoryError
-XX:-OmitStackTraceInFastThrow
-Dawt.useSystemAAFontSettings=lcd
E_O_F

    cp ${properties}.000 ${properties}
    sed -f ${sedfile} -i ${properties}

    set +x

}
