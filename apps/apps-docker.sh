UTLAPPS_docker_init(){
  alias docker-install="UTLAPPS_docker_install"
  alias docker-compose="UTLAPPS_docker_compose"

  alias docker-rmall='docker rm $(docker ps -a -q)'
  alias docker-stopall='docker stop $(docker ps -a -q)'
}

UTLAPPS_docker_env(){
    DOCKER_ROOT="${UTL3RDP_APPS}/docker"
}

UTLAPPS_docker_compose(){
  UTLAPPS_docker_env
  (
    ${DOCKER_ROOT}/tools/docker-compose ${@}
  )
}

UTLAPPS_docker_install(){
  echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
}

UTLAPPS_docker_script(){
  apt-get update

  groupadd docker
  usermod -aG docker ymo

}
