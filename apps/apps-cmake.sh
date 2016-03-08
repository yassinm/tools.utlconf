UTLAPPS_cmake_init(){
    alias cmake-env='UTLAPPS_cmake_env'
    alias cmake-alias='alias | grep cmake'
    alias cmake-build='UTLAPPS_cmake_build'
}

UTLAPPS_cmake_env(){
    utl_init_env

    #CMAKE_VER="3.5.1"
    CMAKE_VER="3.6.0"

    CMAKE_ROOT="${UTL3RDP_APPS}/cmake"
    CMAKE_HOME="${CMAKE_ROOT}/cmake-${CMAKE_VER}-Linux-x86_64"
    PATH=${CMAKE_HOME}/bin:${PATH}
}

UTLAPPS_cmake_tools(){
  cmake -G "Unix Makefiles" \
      -DCMAKE_BUILD_TYPE=Debug \
      -DCMAKE_VERBOSE_MAKEFILE=ON \
      -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \

}

UTLAPPS_cmake_build(){

  cmake \
      -DCMAKE_BUILD_TYPE=Debug \
      -DCMAKE_VERBOSE_MAKEFILE=ON \
      -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
      -DCMAKE_INSTALL_PREFIX=`cd .. && pwd`.dist \
      ${@}

    # -DCMAKE_C_FLAGS_DEBUG="-g3 -gdwarf-2" \
    # -DCMAKE_CXX_FLAGS_DEBUG="-g3 -gdwarf-2" \
}
