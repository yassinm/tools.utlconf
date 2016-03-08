UTLAPPS_netbeans_init(){
   alias netbeans-latest="UTLAPPS_netbeans_latest"
   #alias netbeans-nightly="${NETBEANS_ROOT}/netbeans-trunk-nightly-201606230002/bin/netbeans &"
}

UTLAPPS_netbeans_env(){
   NETBEANS_ROOT="${UTL3RDP_APPS}/netbeans"
   NETBEANS_CPP="${NETBEANS_ROOT}/netbeans-8.0.2.cpp"
   NETBEANS_LATEST="${NETBEANS_ROOT}/netbeans-8.1-201510222201"
}

UTLAPPS_netbeans_latest(){
    UTLAPPS_netbeans_env
    ${NETBEANS_LATEST}/bin/netbeans &
}
