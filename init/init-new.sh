UTLINIT_new_init(){
   alias utl-create='UTLINIT_newfile'
}

UTLINIT_new_test(){
    local lList="vnc local"
    for lName in ${lList} ;  do {
        utl-new i3/wspace/${lName}
    }  done
}

UTLINIT_newfile(){
    set -x
    UTLINIT_newFile ${1}
    set +x
}

UTLINIT_newFile(){
    UTL_PREFIX=""
    UTL_SCANDIR="${UTLCONF}"

    utl_init_scanprefix ${UTLCONF}/${1}
    if [ -z "${UTL_PREFIX}" ] ; then
        return
    fi

    local fPath="${UTLCONF}/${UTL_PREFIX}-${utlName}.sh"
    if [ "${lPrefix}" = "${utlName}" ] ; then
        fPath="${utlDir}/${utlName}.sh"
    fi

    echo going to create ${fPath} ; return

    if [ -e ${fPath} ] ; then
        echo File already exists: ${fPath}; return
    fi

    mkdir -p ${utlDir}

cat << E_O_F > ${fPath}
${utlPrefix}_${utlPath}_init(){
    ${utlPrefix}_${utlPath}_env
}

${utlPrefix}_${utlPath}_env(){
    ${utlPrefix}_ROOT="\${UTL3RDP_APPS}/${utlName}"

    ${utlPrefix}_VER="${utlName}-1.6.0"
    ${utlPrefix}_DIR="\${${utlPrefix}_ROOT}/\${${utlPrefix}_VER}"

    export PATH=\${${utlPrefix}_DIR}:\${PATH}

}

E_O_F


}
