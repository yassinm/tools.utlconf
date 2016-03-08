UTLAPPS_vscode_init(){
   alias vscode-latest="UTLAPPS_vscode_latest"
   alias vscode-insider="UTLAPPS_vscode_insider"
}

UTLAPPS_vscode_env(){
   VSCODE_ROOT="${UTL3RDP_DEV}/vscode"
   VSCODE_LATEST="${VSCODE_ROOT}/vscode-latest"
   VSCODE_GOLANG="${VSCODE_ROOT}/vscode-golang"
   VSCODE_INSIDER="${VSCODE_ROOT}/code-insider-1.13.0-1495088870"
}

UTLAPPS_vscode_latest(){
    UTLAPPS_vscode_env
    ${VSCODE_LATEST}/code ${@} &
}

UTLAPPS_vscode_golang(){
    UTLAPPS_vscode_env
    ${VSCODE_GOLANG}/code ${@} &
}

UTLAPPS_vscode_insider(){
    UTLAPPS_vscode_env
    ${VSCODE_INSIDER}/code-insiders ${@} &
}

UTLAPPS_vscode_install(){
    (
        set +x
         sudo apt-get install liballegro5-dev libicu-dev libtinyxml2-dev cmake build-essential git libunwind8-dev
    )
}
