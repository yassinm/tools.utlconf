#/bin/bash

UTLAPPS_graal_init(){
   local empty
}

UTLAPPS_graal_env(){

    GRAALCFG_VER="graal-core.latest"
    GRAALMX_HOME="${UTL3RDP_GITHUB}/openjdk/mx"
    GRAAL_HOME="${UTL3RDP_GITHUB}/openjdk/graal-core.latest"

    export PATH=${GRAALMX_HOME}:${PATH}

}
