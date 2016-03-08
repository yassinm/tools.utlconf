UTLAPPS_sdkman_init(){
  alias sdkman-env="UTLAPPS_sdkman_env"
}

UTLAPPS_sdkman_env(){
  #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
  export SDKMAN_DIR="${HOME}/.sdkman"
  [[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"
}
