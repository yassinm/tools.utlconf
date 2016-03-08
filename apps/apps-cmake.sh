UTLAPPS_cmake_init(){
    alias cmake-env='UTLAPPS_cmake_env'
    alias cmake-alias='alias | grep cmake'
    alias cmake-debug='UTLAPPS_cmake_debug'
    alias cmake-release='UTLAPPS_cmake_release'
}

UTLAPPS_cmake_env(){
    CMAKE_VER="cmake-3.9.1"
    CMAKE_ROOT="${UTL3RDP_DEV}/cmake"
    CMAKE_HOME="${CMAKE_ROOT}/${CMAKE_VER}"
    PATH=${CMAKE_HOME}/bin:${PATH}
}


UTLAPPS_cmake_debug(){
  (
    set -e

    cmake \
        -DCMAKE_BUILD_TYPE=Debug \
        -DCMAKE_VERBOSE_MAKEFILE=ON \
        -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
        -DCMAKE_INSTALL_PREFIX=`cd .. && pwd`.dist \
        ${@}

    # -DCMAKE_C_FLAGS_DEBUG="-g3 -gdwarf-2"
    # -DCMAKE_CXX_FLAGS_DEBUG="-g3 -gdwarf-2"

    # -DCMAKE_C_COMPILER=gcc-7.1
    # -DCMAKE_CXX_COMPILER=g++-7.1
    # -DCMAKE_C_FLAGS_DEBUG="-std=c++17"
  )

}
UTLAPPS_cmake_git(){
    (
      set -e
      for dname in `find ./putils -name .git` ; do {
        # echo $dname
        echo cd ${dname/\/.git/}
      } done
    )
}

UTLAPPS_cmake_release(){
    (
        set -ex
        mkdir -p build
        cd build

        cmake .. \
            -DCMAKE_VERBOSE_MAKEFILE=ON \
            -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
            -DCMAKE_INSTALL_PREFIX=`cd .. && pwd`.dist \
            ${@}
        
        make && make install
    )
}
