#/bin/bash

UTLAPPS_ponyc_init(){
    local empty
}

UTLAPPS_ponyc_env(){
    PONYC_VER="ponyc-0.1.7"
    PONYC_PCRE="pcre2-10.21.dist"

    PONYC_ROOT="${UTL3RDP_GITHUB}/ponyc"
    PONYC_HOME="${PONYC_ROOT}/${PONYC_VER}"

    export PATH=${PONYC_HOME}/build/release:${PATH}
    export LD_LIBRARY_PATH="${PONYC_ROOT}/${PONYC_PCRE}/lib":${LD_LIBRARY_PATH}
    #export LDFLAGS="-L${PONYC_ROOT}/${PONYC_PCRE}/lib"

}


UTLAPPS_ponyc_build(){
    apt=get install -y \
        zlib1g-devlib libncurses-dev

    pcre path
    ./configure --prefix=${PWD}.dist && make install

     strace -o /tmp/trace.log -e trace=open ponyc

    ponyc -p /home/ymo/3rdp/github/ponyc/pcre2-10.21.dist/lib/
}
