UTLDOCKER_tunnels_init(){
    alias docker-tunnel-10-200='UTLDOCKER_tunnels_10_200'
}

UTLDOCKER_tunnels_env(){
    TUNNEL26="tunnel26"
}

UTLDOCKER_tunnels_start(){
    docker start ${TUNNEL26}
}

UTLDOCKER_tunnels_create(){
    (
        set -x
        UTLDOCKER_tunnels_env
        UTLDOCKER_tunnels_createTunnel ${TUNNEL26}
    )
}

UTLDOCKER_tunnels_createTunnel(){
    (
        set -x

        local tunnelName="${1}"
        if [ -z "${tunnelName}" ] ; then
           echo "tunnelName must be provided" ; return
        fi

        docker create \
            --ip 10.200.111.26 \
            --name=${tunnelName} \
            debian:jessie

    )

}
