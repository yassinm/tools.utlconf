UTLAPPS_golang_init(){
  alias golang-alias='alias | grep golang'

  alias golang-env="UTLAPPS_golang_env"
  alias golang-list="UTLAPPS_golang_list"
  alias golang-wspace="UTLAPPS_golang_wspace"

  alias vscode-golang="UTLAPPS_golang_vscode"
}

UTLAPPS_golang_vars(){
  GOLANG_VERSION="go1.8"
  GOLANG_HOMEDIR="${UTL3RDP_DEV}/golang"
}

UTLAPPS_golang_run(){
  (
    set -e
    UTLAPPS_golang_env
    golang ${@}
  )
}

UTLAPPS_golang_vscode(){
  (
    set -ex
    UTLAPPS_golang_env
    UTLAPPS_vscode_golang ${@}
  )
}


UTLAPPS_golang_list(){
  UTLAPPS_golang_vars
  (
    cd ${GOLANG_HOMEDIR}
    find . -maxdepth 1 -name "wspace-*" -type d 
  )
}

UTLAPPS_golang_env(){
  UTLAPPS_golang_vars

  export GOPATH="${GOLANG_HOMEDIR}/packages"
  export GOROOT="${GOLANG_HOMEDIR}/${GOLANG_VERSION}"
  PATH=${GOROOT}/bin:${GOPATH}/bin:${PATH}
}

UTLAPPS_golang_wspace(){
  UTLAPPS_golang_vars

  local lWspace="${1}"
  if [ -z "${lWspace}" ] ; then
      echo You forgot to pass a wspace name; return
  fi

  export GOPATH="${GOLANG_HOMEDIR}/wspace-${lWspace}"
  export GOROOT="${GOLANG_HOMEDIR}/${GOLANG_VERSION}"
  PATH=${GOROOT}/bin:${GOPATH}/bin:${PATH}
}

UTLAPPS_golang_prompt(){
  local command="${1}"
  local environment="${2}"

  if [ "${command-}" = "deactivate" ] ; then
    if ! [ -z "${_OLD_GOLANG_PS1+_}" ] ; then
        PS1="$_OLD_GOLANG_PS1"
        export PS1
        unset _OLD_GOLANG_PS1
    fi
  elif [ "${command-}" = "activate" ] ; then
    _OLD_GOLANG_PS1="$PS1"
    if [ "x" != x ] ; then
        PS1="$PS1"
    else
        PS1="(`basename \"${environment}\"`) $PS1"
    fi
    export PS1
  fi
}
