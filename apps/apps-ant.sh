UTLAPPS_ant_init(){
  alias ant-run="UTLAPPS_ant_run"
  alias ant-env="UTLDEV_ant_env"
  alias ant-alias='alias | grep ant'
}

UTLAPPS_ant_env(){
  ANT_VERSION="1.10.0"
  ANT_HOME="${UTL3RDP_APPS}/apache/ant/apache-ant-${ANT_VERSION}"
  PATH=${ANT_HOME}/bin:${PATH}
}

UTLAPPS_ant_run(){
  (
    set -ex
    UTLAPPS_ant_env
    ant ${@}
  )
}
