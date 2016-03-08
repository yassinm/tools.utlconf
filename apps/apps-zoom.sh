UTLAPPS_zoom_init(){
  alias zoom-run='UTLAPPS_zoom_run'
  alias zoom-install='UTLAPPS_zoom_install'
  alias zoom-alias='alias | grep zoom'
}

UTLAPPS_zoom_run(){
  (
    UTLAPPS_zoom_env
    # ${ZOOM_HOME}/zoom
    ${ZOOM_HOME}/ZoomLauncher
  )
}

UTLAPPS_zoom_env(){
  # ZOOM_VERSION="zoom_x86_64.2.0.91373.0502"
  ZOOM_VERSION="zoom_x86_64.2.0.98253.0707"
  ZOOM_HOME="${UTL3RDP_APPS}/zoom/${ZOOM_VERSION}"
  export PATH="${ZOOM_HOME}:${PATH}"
  # export LD_LIBRARY_PATH="${ZOOM_HOME}"
}

UTLAPPS_zoom_install(){

  sudo apt-get install -y \
    libglib2.0-0 \
    libxcb-shape0 \
    libxcb-shm0 \
    libxcb-xfixes0 \
    libxcb-randr0 \
    libxcb-image0 \
    libfontconfig1 \
    libgl1-mesa-glx \
    libxi6 \
    libsm6 \
    libxrender1 \
    libpulse0 \
    libxcomposite1 \
    libxslt1.1 \
    libsqlite3-0 \
    libxcb-keysyms1 \
    libxcb-xtest0 \

    apt-get install -y \
      libxcb-shape0:i386 libxcb-shm0:i386 libxcb-xfixes0:i386 libxcb-randr0:i386 libxcb-xtest0


}
