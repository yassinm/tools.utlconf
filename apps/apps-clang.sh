UTLAPPS_clang_init(){
    local empty
}

UTLAPPS_clang_env(){
    #set -x
    CLANG_ROOT="${UTL3RDP_GITHUB}/clang"

    CLANG_VER="RELEASE_380"
    CLANG_DIR="${CLANG_ROOT}/${CLANG_VER}"

    export PATH=${CLANG_ROOT}/clang-${CLANG_VER}.dist/bin:${PATH}
    #hash clang
    #set +x

}
