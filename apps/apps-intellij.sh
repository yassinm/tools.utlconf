UTLAPPS_intellij_init(){
    UTLAPPS_intellij_env

    alias idea-conf="UTLAPPS_intellij_conf"
    alias idea-clean="UTLAPPS_intellij_clean"
    alias idea-golang="${INTELLIJ_ROOT}/${INTELLIJ_GOLANG}/bin/idea.sh &"
    alias idea-latest="${INTELLIJ_ROOT}/${INTELLIJ_LATEST}/bin/idea.sh &"
}

UTLAPPS_intellij_keymap(){
cat <EOF>> /tmp/
    "select in project view" Ctrl+Esc
EOF
}

UTLAPPS_intellij_env(){
    #set -x

    INTELLIJ_LATEST="idea-latest"
    INTELLIJ_GOLANG="idea-golang"

    INTELLIJ_CFG=".IdeaIC"
    INTELLIJ_ROOT="${UTL3RDP_DEV}/intellij"

    #set +x
}

UTLAPPS_intellij_clean(){
    (
        set -ex
        find . -name "*.iml" | xargs -I{} rm -f "{}" 
        find . -name "*.ipr" | xargs -I{} rm -f "{}" 
        find . -name "*.iws" | xargs -I{} rm -f "{}" 
        find . -type d -name ".idea" | xargs -I{} rm -rf "{}" 
    )
}

UTLAPPS_intellij_conf(){

    UTLAPPS_intellij_env

    local lVersion="${1}"
    #local lVersion="${lDir##*/}"

    if [ -z "${lVersion}" ] ; then
        echo you must pass version for configurations; return
    fi

    local lDir="${INTELLIJ_ROOT}/${lVersion}"
    if ! [ -e "${lDir}" ] ; then
        echo "missing dir ${lDir}"  ; return
    fi

    set -x

    local dname_idea="${INTELLIJ_ROOT}/${lVersion}"
    local dname_conf="${INTELLIJ_ROOT}/conf/conf-${lVersion}"

    local sedfile="${dname_conf}/${lVersion}.sed"
    local vmoptions="${dname_idea}/bin/idea64.vmoptions"
    local properties="${dname_idea}/bin/idea.properties"

    mkdir -p ${dname_conf}
    mkdir -p ${dname_idea}/${INTELLIJ_CFG}/config/codestyles
    mkdir -p ${dname_idea}/${INTELLIJ_CFG}/config/inspection

    if ! [ -e ${vmoptions}.000 ] ; then
        cp ${vmoptions} ${vmoptions}.000
    fi

    if ! [ -e ${properties}.000 ] ; then
        cp ${properties} ${properties}.000
    fi

   cat <<E_O_F>${sedfile}
s@^.*idea.log.path=.*@idea.log.path=\${idea.home.path}/${INTELLIJ_CFG}/system/log@g
s@^.*idea.config.path=.*@idea.config.path=\${idea.home.path}/${INTELLIJ_CFG}/config@g
s@^.*idea.system.path=.*@idea.system.path=\${idea.home.path}/${INTELLIJ_CFG}/system@g
s@^.*idea.plugins.path=.*@idea.plugins.path=\${idea.home.path}/${INTELLIJ_CFG}/config/plugins@g
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
