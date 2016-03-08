UTLAPPS_atom_init(){
  alias atom-env="UTLAPPS_atom_env"
  alias atom-new="UTLAPPS_atom_new"
  alias atom-start="UTLAPPS_atom_start"
}

UTLAPPS_atom_new(){
  (
    UTLAPPS_atom_env
    atom -n ${@} &
  )
}

UTLAPPS_atom_start(){
  (
    UTLAPPS_atom_env
    atom -n ${UTLCONF_FOLDERS} ${@} &
  )
}

UTLAPPS_atom_env(){
  UTLAPPS_atom_vars
  export LANG=en_US.UTF-8
  export ATOM_HOME="${UTLAPPS_ATOM_DIR}/conf"
  export PATH=${UTLAPPS_ATOM_DIR}:${UTLAPPS_ATOM_DIR}/resources/app/apm/bin:${PATH}
}

UTLAPPS_atom_vars(){
    #set -x

    UTLAPPS_ATOM_VER="atom-latest"
    #UTLAPPS_ATOM_VER="atom-1.14.1-amd64"

    UTLAPPS_ATOM_ROOT="${UTL3RDP_DEV}/atom"
    UTLAPPS_ATOM_DIR="${UTLAPPS_ATOM_ROOT}/${UTLAPPS_ATOM_VER}"

    #set +x
}
