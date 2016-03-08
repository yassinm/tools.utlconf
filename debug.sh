utl_dbg_off(){
    local fPath="${1}"
    if ! [ "${fPath/$dbgPath}" = "$fPath" ] ; then
        set +x
    fi
}

utl_dbg_on(){
    local fPath="${1}" #; echo $fPath && return
    if ! [ "${fPath/$dbgPath}" = "$fPath" ] ; then
        set -x
    fi
}

utl_dbg_file(){
    dbg_file=""
}

utl_dbg_test(){
    utl_env

cat <<E_O_F> /tmp/utldebug.sh
#!/bin/bash

set -e

source "${UTLCONF}/init.sh"
utl_init

echo $PATH

E_O_F

    #chmod +x /tmp/utldebug.sh
    #/bin/bash -x /tmp/utldebug.sh

}
