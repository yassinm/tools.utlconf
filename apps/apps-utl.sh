UTLAPPS_utl_init(){
    UTLAPPS_utl_env

    #alias jar-list='unzip -l'
    alias utl-jar-list='unzip -l'
    alias utl-ps='ps -eo pid,user,args'
    alias utl-jar-find='find . -name "*.jar"'


    alias ubuntu-version="cat /etc/os-release"
}

UTLAPPS_utl_env(){
    UTL_ROOT="${UTL3RDP_APPS}/utl"
}

UTLAPPS_utl_kill(){
  ps -ef | grep "${1}" | grep -v grep | awk '{print $2}' | xargs kill -9
}
