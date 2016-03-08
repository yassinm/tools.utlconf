UTLAPPS_golang_init(){
  alias golang-alias='alias | grep golang'

  alias golang-env="UTLAPPS_golang_env"
  alias golang-grep="UTLAPPS_golang_grep"

  alias golang-list="UTLAPPS_golang_list"
  alias golang-clone="UTLAPPS_golang_clone"
  alias golang-wspace="UTLAPPS_golang_wspace"
  alias golang-source="UTLAPPS_golang_source"
}

UTLAPPS_golang_grep(){
  grep -r --include "*.go" --exclude-dir=vendor --exclude-dir=dep ${@}
}

UTLAPPS_golang_vars(){
  # GOLANG_VERSION="go1.9.0"
  GOLANG_VERSION="go1.8.5"
  GOLANG_HOMEDIR="${UTL3RDP_DEV}/golang"
}

UTLAPPS_golang_run(){
  (
    set -e
    UTLAPPS_golang_env
    golang ${@}
  )
}

UTLAPPS_golang_dlv(){
  dlv test ./tests -- -test.run TestTree_000
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

  export GOROOT="${GOLANG_HOMEDIR}/${GOLANG_VERSION}"
  export GOPATH="${GOLANG_HOMEDIR}/${GOLANG_VERSION%.*}.packages"

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
  export PATH=${GOROOT}/bin:${GOPATH}/bin:${PATH}

  echo new wspace is located at ${GOPATH}

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

UTLAPPS_golang_source(){
  (
    set -ex

    local ppath="${1}"
    local gitpath="${2}"

    if [ -z "${ppath}" ] ; then
      echo you must pass a project ; return
    fi

    if [ -z "${gitpath}" ] ; then
      echo you must pass a gitpath:branch; return
    fi

    local branchName="${gitpath##*:}"
    local projectPath="${gitpath%%:*}"
    if [ "${projectPath}" = "${gitpath}" ] ; then
      branchName="master"
    fi

    local projectName="${projectPath##*/}"
    local projectDir="${projectPath%/*}"
    # mkdir -p ${GOPATH}/${projectDir}
    # git clone 
  )

}

UTLAPPS_golang_clone1(){
  (
    set -ex

    local dname="${1}"
    local branchName="${2}"

    if [ -z "${dname}" ] ; then
      echo you must pass a directory name; return
    fi

    local dprefix="${dname%/*}"
    if [ "${dprefix}" = "${dname}" ] ; then
      dprefix="github.com/hypersuite"
    fi


    local dpath="$GOPATH/src/${dprefix}"
    local sourceUrl="ssh://ymo@192.168.2.11:29418/${dname}.git"

    local gitpath="${dpath}/${dname}"
    if ! [ -e "${gitpath}/.git" ] ; then
      mkdir -p "${dpath}"
      cd ${dpath}
      git clone ${sourceUrl} ${dname}
    fi

    cd ${gitpath}

    if ! [ -z "${branchName}" ] ; then
        git checkout ${branchName}
    fi

  )

}

UTLAPPS_golang_clone2(){
  (
    set -ex

    local dname="${1}"
    local sourceUrl="${2}"
    local branchName="${3}"

    if [ -z "${gitUrl}" ] ; then
      echo you must pass a gitUrl as the 1st argument; return
    fi

    if [ -z "${sourceUrl}" ] ; then
      echo you must pass a sourceUrl as the 2nd argument; return
    fi

    gitUrl="${gitUrl%/}"
    gitUrl="${gitUrl%.git}"

    if [ -z "${gitUrl}" ] ; then
        echo You must pass a url to clone; return
    fi

    local gitproject="${gitUrl##*://}"
    
    local dname="${gitproject##*/}"
    if [ "${dname}" = "${gitUrl}" ] ; then
      echo invalid url; return 
    fi 

    local dpath="${gitproject%/*}"
    if [ "${dpath}" = "${gitUrl}" ] ; then
      echo invalid dpath; return 
    fi

    if ! [ -e $GOPATH/src/${dpath}/${dname} ] ; then
      echo mkdir -p $GOPATH/src/${dpath}
      echo cd $GOPATH/src/${dpath}
      echo git clone ${sourceUrl} ${dname}
    fi

    return

  )

}
