UTLAPPS_hugo_init(){
  alias hugo-env="UTLAPPS_hugo_env"
  alias hugo-serve="hugo server -D --bind 192.168.2.10 --baseUrl 192.168.2.10"
}

#-------------------------------------------------------------------------------

UTLAPPS_hugo_env(){
   export HUGO_HOME="${UTL3RDP_APPS}/hugo/hugo-latest"
   export PATH=${HUGO_HOME}:${PATH}
}
