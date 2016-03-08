UTLAPPS_conan_init(){
  alias conan-env='UTLAPPS_conan_env'
}

UTLAPPS_conan_activate(){
  CONAN_ROOT="${UTL3RDP_APPS}/conan"
  CONAN_HOME="${CONAN_ROOT}/${CONAN_VER}"
  source ${CONAN_HOME}/bin/activate
}

UTLAPPS_conan_env(){
  CONAN_VER="conan-latest"
  UTLAPPS_conan_activate
}

