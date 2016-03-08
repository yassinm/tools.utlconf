UTLAPPS_dpdk_init(){
    UTLAPPS_dpdk_env
}

UTLAPPS_dpdk_env(){
    DPDK_ROOT="${UTL3RDP_GITHUB}/dpdk"

    DPDK_VER="dpdk-16.04"

    #export PATH=${DPDK_DIR}:${PATH}
    
    export RTE_SDK="${DPDK_ROOT}/${DPDK_VER}"
    export RTE_TARGET=x86_64-native-linuxapp-gcc


}
