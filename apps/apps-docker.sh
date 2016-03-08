UTLAPPS_docker_init(){
  alias docker-env="UTLAPPS_docker_env"
  alias docker-script="UTLAPPS_docker_script"

  alias docker-install="UTLAPPS_docker_install"
  alias docker-compose="UTLAPPS_docker_compose"

  alias docker-rmall='docker rm $(docker ps -a -q)'
  alias docker-stopall='docker stop $(docker ps -a -q)'
}

UTLAPPS_docker_env(){
  DOCKER_VERSION="docker-17.04.0-ce"
  DOCKER_ROOT="${UTL3RDP_APPS}/docker"
  DOCKER_LOCATION="${DOCKER_ROOT}/${DOCKER_VERSION}"
  export PATH=${DOCKER_LOCATION}:${PATH}
}

UTLAPPS_docker_compose(){
  UTLAPPS_docker_env
  (
    ${DOCKER_ROOT}/tools/docker-compose ${@}
  )
}

UTLAPPS_docker_script(){
  UTLAPPS_docker_env

cat <<E_O_F> ${DOCKER_ROOT}/docker.sh
#!/bin/bash

UTLAPPS_docker_script(){
  (
    set -e
    export PATH=${DOCKER_LOCATION}:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
    dockerd -D -g /data/3rdp/vsys/docker/data
  )
}

UTLAPPS_docker_script \${@}
E_O_F

}

UTLAPPS_docker_install(){
  echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list

  apt-get update
  groupadd docker
  usermod -aG docker ymo
}
