UTLAPPS_clang_init(){
  alias clang-4='UTLAPPS_clang_4_0_2'
}

UTLAPPS_clang_env(){
  CLANG_ROOT="${UTL3RDP_APPS}/clang"
  CLANG_HOME="${CLANG_ROOT}/${CLANG_VER}"

  export PATH=${CLANG_HOME}/bin:$PATH

}

UTLAPPS_clang_4_0_2(){
  CLANG_VER="clang+llvm-4.0.1"
  UTLAPPS_clang_env
}

UTLAPPS_clang_release(){
  (
    set -e

    cmake-debug .. -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang -DCMAKE_CXX_FLAGS="-std=c++1z -stdlib=libc++"
  )
}
