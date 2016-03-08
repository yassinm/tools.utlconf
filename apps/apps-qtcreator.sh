#!/bin/bash

UTLAPPS_qtcreator_init(){
    alias qtcreator_4_0='UTLAPPS_qtcreator_4_0'
}

UTLAPPS_qtcreator_env(){
    QTCREATOR_ROOT="${UTL3RDP_APPS}/qtcreator"
}

UTLAPPS_qtcreator_4_0(){
    UTLAPPS_qtcreator_env

    #set -x
    UTLAPPS_qtcreator_conf qtcreator-4.0 && qtcreator &
    #set +x
}

UTLAPPS_qtcreator_conf(){
    utl_init_env

    local lVersion="${1}"
    if [ -z "${lVersion}" ] ; then
        echo dir path was not provided ; return
    fi

    export PATH=${QTCREATOR_ROOT}/${lVersion}/Tools/QtCreator/bin/:${PATH}
}
