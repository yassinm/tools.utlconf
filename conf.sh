alias _utlinit='utl_init'

utl_init(){
  utl_init_env
  source "${UTLCONF}/conf.sh"
  utl_init_load
}

utl_init_load(){

    utl_init_env
    utl_init_path
    utl_init_agent

    source "${UTLCONF}/libs.sh"
    source "${UTLCONF}/debug.sh"

    #set -x
    utl_lib_checkOs
    utl_lib_parseArgs ${@}
    #set +x

    utlinit_scanpath ${UTLCONF}


}

utl_init_agent(){
    #set -x

    alias keys-init="utl_init_agent"

    if [ -z "${SSH_AGENT_PID}" ] ; then
        ssh-agent -s > ~/.ssh/agent
    else
cat << E_O_F > ~/.ssh/agent
SSH_AUTH_SOCK=$SSH_AUTH_SOCK; export SSH_AUTH_SOCK;
SSH_AGENT_PID=$SSH_AGENT_PID; export SSH_AGENT_PID;
echo Agent pid $SSH_AGENT_PID;
E_O_F
    fi

    if [ -e ~/.ssh/agent ] ; then
        source ~/.ssh/agent
    fi

    #set +x
}

utl_init_env(){
  dbgPath=""
  dbgEnabled=""

  UTLFILE="${HOME}/.utlconf"
  UTLCONF_BASHRC="${HOME}/.bashrc"

  if [ -z "${UTLCONF}" ] ; then
    UTLCONF="${HOME}/work/_utl/utl-conf"
  fi 
  
}

utl_init_path(){

    export UTL3RDP="${HOME}/3rdp"
    export UTL3RDP_DEV="${HOME}/3rdp.dev"
    export UTL3RDP_APPS="${UTL3RDP}/apps"
    export UTL3RDP_GAMES="${UTL3RDP}/games"
    export UTL3RDP_GITHUB="${UTL3RDP}/github"


    #set +x

    if ! [ -e ${UTLFILE} ] ; then
cat << E_O_F > ${UTLFILE}
UTLCONF_LDPATH="${LD_LIBRARY_PATH}"
UTLCONF_PYTHONPATH="${PYTHONPATH}"
UTLCONF_PATH="${PATH}"
UTLCONF_PS1="${PS1}"
E_O_F
    fi

    source ${UTLFILE}

    export PS1="${UTLCONF_PS1}\n$"
    export PATH="${UTLCONF_PATH}"
    export PYTHONPATH="${UTLCONF_PYTHONPATH}"
    export LD_LIBRARY_PATH="${UTLCONF_LDPATH}"

}

utlinit_scanpath(){
    local dPath="${1}"
    if ! [ -e "${dPath}" ] ; then
          return
    fi

    UTL_SCANDIR="${dPath}"
    utl_init_scandir ${dPath}
    UTL_SCANDIR=""

}

utl_init_scandir(){
    local dPath="${1}"
    local lPrefix="${dPath##*/}"
    lPrefix="${lPrefix##*-}"

    # local fPath="${dPath}/${lPrefix}.sh"
    # if ! [ -e "${fPath}" ] ; then
    #     return
    # fi

    if ! [ -z "${dbgEnabled}" ] ; then
        echo "scanning $dPath"
    fi

    for fPath in `find ${dPath} -type f -path "*/*.sh" -and -not -path "*/.*"` ; do {
        #echo $fPath ; continue

        UTLFILELOC=""
        utl_init_scanfile ${fPath}
        if ! [ -z "${UTLFILELOC}" ] ; then
            if ! [ -z "${dbgEnabled}" ] ; then
                echo "loaded $fPath"
            fi
        fi
    } done

}

utl_init_scanfile(){
  (
    set -ex

    local fPath="${1}"

    utl_init_scanprefix ${fPath}
    if [ -z "${UTL_PREFIX}" ] ; then
        return
    fi

    local initName="UTL${UTL_PREFIX^^}_init"
    if ! [ "${UTL_MODULE}" = "${UTL_PREFIX}" ] ; then
        initName="UTL${UTL_PREFIX^^}_${UTL_MODULE}_init"
    fi

    echo "---------------------------------------------------"
    echo scanning file ${fPath} ; return

    if [ -e "${fPath}" ] ; then

        local hasName=`grep "^${initName}\(\)" ${fPath} | wc -l`

        if ! [ "${hasName}" = "1" ] ; then
            return
        fi

        source ${fPath}
        local fname=`declare -f -F ${initName}`

        #set -x

        if [ -n "${fname}" ] ; then
            ${initName}
            UTLFILELOC="${fPath}"
        fi

        #set +x

    fi

  )
}

utl_init_scanprefix(){
    local lPath="${1}"
    lPath="${lPath/.sh/}"

    UTL_PREFIX=""
    UTL_MODULE=""

    local lMod=""
    local lMod1=""
    local lMod2=""
    local lModule=""

    local lPrefix=""
    local lPrefix0=""
    local lPrefix1=""

    if [ -z "${lPath}" ] ; then
        echo "scan prefix with empty dir" ; return
    fi

    if [ "${lPath: -1}" == "/" ] ; then
        echo "prefix path cannot end with /" ; return
    fi

    #is it outside scan path ?
    local lScan="${lPath/$UTL_SCANDIR}"
    if [ "${lScan}" = "${lPath}" ] ; then
        echo "prefix outside scan path" ; return
    fi

    #echo "utl_init_scanprefix ---------------------------------------------------"

    lPath="${lScan#*/}"

    lMod="${lPath##*/}"
    lMod1="${lMod%%-*}"
    lMod2="${lMod#*-}"

    lPrefix0="${lPath##*/}"
    lPrefix="${lPath%%/*}"
    lPrefix1="${lPath%/*}"
    lPrefix1="${lPrefix1##*/}"

    if [ "/${lPath}" = "${lScan}" ] ; then
        #special case for top directories
        local empty=0
        lPrefix="${lMod1}"
        lModule="${lMod2/-/_}"
        #we have simplest case
    elif [ "${lMod}" = "${lPrefix}" ] ; then
        local empty=1
        lModule="${lMod}"
    elif ! [ "${lMod1}" = "${lPrefix1}" ] ; then
        #we have an error
        local empty=2
        return
    elif [ "${lPrefix0}" = "${lPrefix1}" ] ; then
        local empty=3
        lModule="${lPrefix0}"
    else
        local empty=4
        lModule="${lMod2/-/_}"
    fi

    UTL_PREFIX="${lPrefix}"
    UTL_MODULE="${lModule}"

}

utl_init_env