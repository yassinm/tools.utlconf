UTLAPPS_gcc_init(){
  alias gcc-7='UTLAPPS_gcc_7_1'
}

UTLAPPS_gcc_env(){
  GCC_ROOT="${UTL3RDP_APPS}/gcc"
  GCC_HOME="${GCC_ROOT}/${GCC_VER}"
  PATH=${GCC_HOME}/bin:${PATH}

  export PATH=${GCC_HOME}/bin:$PATH
  export LD_LIBRARY_PATH=${GCC_HOME}/lib64:$LD_LIBRARY_PATH

}

UTLAPPS_gcc_7_1(){
  GCC_VER="gcc-7.1.0.dist"
  UTLAPPS_gcc_env
}

UTLAPPS_gcc_release(){
  (
    set -e
  )
}
