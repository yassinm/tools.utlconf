UTLAPPS_flutter_init(){
  alias flutter-env="UTLAPPS_flutter_env"
  alias flutter-alias='alias | grep flutter'
}

UTLAPPS_flutter_env(){
  FLUTTER_VERSION="flutter-latest"
  FLUTTER_HOME="${UTL3RDP_GITHUB}/flutter/${FLUTTER_VERSION}"
  export PATH=${FLUTTER_HOME}/bin:${PATH}
}

UTLAPPS_flutter_build(){
  UTLAPPS_flutter_env
  (
    set -xe

    cd ${FLUTTER_HOME}
    mkdir -p lib third_party apps/modules

    cd ${FLUTTER_HOME}/apps
    if [ -e sysui ] ; then
      cd sysui && git pull --ff-only
    else
      git clone https://github.com/fuchsia-mirror/sysui.git
    fi

    cd ${FLUTTER_HOME}/apps/modules
    if [ -e common ] ; then
      cd common && git pull --ff-only
    else
      git clone https://github.com/fuchsia-mirror/modules-common.git common
    fi

    cd ${FLUTTER_HOME}/lib
    if [ -e widgets ] ; then
      cd widgets && git pull --ff-only
    else
      git clone https://fuchsia.googlesource.com/widgets
    fi

    cd ${FLUTTER_HOME}/third_party
    if [ -e dart-pkg ] ; then
      cd dart-pkg && git pull --ff-only
    else
      git clone https://github.com/fuchsia-mirror/third_party-dart-pkg dart-pkg
    fi

    cd ${FLUTTER_HOME} && flutter upgrade

  )

}
