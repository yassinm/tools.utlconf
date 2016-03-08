UTLAPPS_cloudera_init(){
    UTLAPPS_cloudera_env

    alias cloudera-run='docker run --privileged=true \
      -p 8000:80 \
      -p 8888:8888 \
      --hostname=quickstart.cloudera\
      -it cloudera/quickstart \
      /usr/bin/docker-quickstart'
}

UTLAPPS_cloudera_env(){
    CLOUDERA_ROOT="${UTL3RDP_APPS}/cloudera"
}
