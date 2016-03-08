UTLAPPS_vscode_init(){
   alias vscode-latest="UTLAPPS_vscode_latest"
   alias vscode-insiders="UTLAPPS_vscode_insiders"
}

UTLAPPS_vscode_env(){
   VSCODE_ROOT="${UTL3RDP_DEV}/vscode"
   VSCODE_LATEST="${VSCODE_ROOT}/vscode-latest"
   VSCODE_GOLANG="${VSCODE_ROOT}/vscode-golang"
   VSCODE_INSIDER="${VSCODE_ROOT}/vscode-insiders"
}

UTLAPPS_vscode_latest(){
    UTLAPPS_vscode_env
    ${VSCODE_LATEST}/code ${@} &
}

UTLAPPS_vscode_insiders(){
  (
    set -e
    UTLAPPS_golang_env
    UTLAPPS_nodejs_6x

    UTLAPPS_vscode_env
    ${VSCODE_INSIDER}/code-insiders ${@} &
  )

}

UTLAPPS_vscode_preferences(){
  cat <<-EOF > /tmp/vscode
  {
    "go.inferGopath" :true,

    "workbench.activityBar.visible": true,
    "editor.minimap.enabled": false,
    "workbench.editor.revealIfOpen": true,
    
    "zenMode.hideTabs": false,
    "workbench.startupEditor": "none",
    "editor.renderControlCharacters": true,
    "editor.renderWhitespace": "all"
  }
	EOF

}
