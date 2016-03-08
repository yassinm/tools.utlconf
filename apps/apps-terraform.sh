UTLAPPS_terraform_init(){
  alias terraform-env="UTLAPPS_terraform_env"
  alias terraform-alias='alias | grep terraform'
}

UTLAPPS_terraform_env(){
  TERRAFORM_VERSION="terraform_0.7.0"
  TERRAFORM_HOME="${UTL3RDP_APPS}/terraform/${TERRAFORM_VERSION}"
  export PATH=${TERRAFORM_HOME}:${PATH}
}

UTLAPPS_terraform_run(){
  (
    set -ex
    UTLAPPS_terraform_env
    terraform ${@}
  )
}
