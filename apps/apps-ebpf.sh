UTLAPPS_ebpf_init(){
  alias ebpf-env="UTLAPPS_ebpf_env"
  alias ebpf-alias='alias | grep ebpf'
}

UTLAPPS_ebpf_env(){
  EBPF_VERSION="bcc-latest.dist"
  EBPF_ROOT="${UTL3RDP_GITHUB}/ebpf"
  EBPF_HOME="${EBPF_ROOT}/${EBPF_VERSION}"
  export PATH=${EBPF_HOME}/bin:${EBPF_HOME}/share/bcc/tools:${PATH}
  export LD_LIBRARY_PATH=${EBPF_HOME}/lib:$LD_LIBRARY_PATH
  export PYTHONPATH="${EBPF_HOME}/lib/python2.7/dist-packages"
  source ${EBPF_ROOT}/bcc-env/bin/activate
}

UTLAPPS_ebpf_file(){
	cat <<-E_O_F> ${EBPF_ROOT}/ebpf.env
    EBPF_VERSION="bcc-latest.dist"
    EBPF_ROOT="${UTL3RDP_GITHUB}/ebpf"
    EBPF_HOME="${EBPF_ROOT}/${EBPF_VERSION}"
    export PATH=${EBPF_HOME}/bin:${EBPF_HOME}/share/bcc/tools:${PATH}
    export LD_LIBRARY_PATH=${EBPF_HOME}/lib:$LD_LIBRARY_PATH
    export PYTHONPATH="${EBPF_HOME}/lib/python2.7/dist-packages"
    source ${EBPF_ROOT}/bcc-env/bin/activate
	E_O_F
}
