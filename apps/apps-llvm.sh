UTLAPPS_llvm_init(){
    alias llvm-env-debug="UTLAPPS_llvm_env debug"
    alias llvm-env-release="UTLAPPS_llvm_env release"
    alias llvm-build-debug="UTLAPPS_llvm_build Debug"
    alias llvm-build-release="UTLAPPS_llvm_build Release"

}

UTLAPPS_llvm_env(){
    local buildType="${1}"

    LLVM_VER="llvm-RELEASE_390"
    LLVM_ROOT="${UTL3RDP_GITHUB}/llvm"
    LLVM_DIR="${LLVM_ROOT}/${LLVM_VER}.dist.${buildType}"
    export PATH=${LLVM_DIR}/bin:${PATH}
}

UTLAPPS_llvm_src(){
  set -x

  UTLAPPS_llvm_env ; #return

  if ! [ -e "${buildDir}" ] ; then
      cd  ${LLVM_ROOT}

      svn co http://llvm.org/svn/llvm-project/llvm/tags/${LLVM_VER}/final ${LLVM_VER}

      cd ./${LLVM_VER}/tools
      svn co http://llvm.org/svn/llvm-project/cfe/tags/${LLVM_VER}/final clang

      cd ../projects/
      svn co http://llvm.org/svn/llvm-project/compiler-rt/tags/${LLVM_VER}/final compiler-rt
  fi

  set +x
}

UTLAPPS_llvm_build(){
  (
    set -ex

    local buildType="${1}"
    local bType="${buildType,,}"

    # echo ${bType} ; return

    UTLAPPS_llvm_env ${bType} #;return

    local THREADS=$(grep -c ^processor /proc/cpuinfo)
    local distDir="${LLVM_ROOT}/${LLVM_VER}.dist.${bType}"
    local buildDir="${LLVM_ROOT}/${LLVM_VER}/build/${bType}"

    mkdir -p ${buildDir} && cd ${buildDir}
    cmake -DCMAKE_BUILD_TYPE:STRING=${buildType} \
        -DCMAKE_INSTALL_PREFIX=${distDir} ../..

    # make -j $THREADS && make install

    set +x
  )

}
