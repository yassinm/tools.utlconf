UTLAPPS_netdata_init(){
    alias netdata-run="UTLAPPS_netdata_run"
    alias netdata-install="UTLAPPS_netdata_install"
}

UTLAPPS_netdata_env(){
    UTLAPPS_NETDATA_LATEST="netdata-latest"
    UTLAPPS_NETDATA_VER="netdata-latest.dist"
    UTLAPPS_NETDATA_ROOT="${UTL3RDP_GITHUB}/netdata"
}

UTLAPPS_netdata_run(){
  (
    #set -x
    UTLAPPS_netdata_env
    local lDir="${UTLAPPS_NETDATA_ROOT}/${UTLAPPS_NETDATA_VER}"
    ${lDir}/netdata/usr/sbin/netdata -D ${@}
  )
}

UTLAPPS_netdata_install(){
  (
    set -ex
    UTLAPPS_netdata_env
    local lDir=""
    cd ${UTLAPPS_NETDATA_ROOT}/${UTLAPPS_NETDATA_LATEST} && ./netdata-installer.sh --install ${PWD}.dist
  )
}

UTLAPPS_netdata_statsd() {
  set -e
  STATSD_PORT="8125"
  STATSD_HOST="localhost"
  local udp="-u" all="${*}"

  # if the string length of all parameters given is above 1000, use TCP
  [ "${#all}" -gt 1000 ] && udp=

  while [ ! -z "${1}" ]
  do
      printf "${1}\n"
          shift
  done | nc ${udp} -w0  ${STATSD_HOST} ${STATSD_PORT} || return 1
  # done | nc ${udp} --send-only ${STATSD_HOST} ${STATSD_PORT} || return 1

}

UTLAPPS_netdata_tests() {
   (
    set -e
      local index=0
      local pi=`echo "4*a(1)" | bc -l`

    while true ; do {
      sleep 1
      let index=index+10
      rad=`echo "$index*($pi/180)" | bc -l`
      local g1Value=`echo "scale=2; c($rad)*100+100" | bc -l`
      local g2Value=`echo "scale=2; s($rad)*100+100" | bc -l`

      echo "myapp.metric1:${g1Value}|g" > /dev/udp/localhost/8125
      echo "myapp.metric2:${g2Value}|g" > /dev/udp/localhost/8125
      # printf "myapp.metric1:${g1Value}|g\nmyapp.metric2:${g2Value}|g\n" | nc -u -w0 localhost 8125

      echo "g1Value:${g1Value} g2Value:${g2Value}"


    } done
    
  )

}
