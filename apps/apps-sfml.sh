UTLAPPS_sfml_init(){
    UTLAPPS_sfml_env
}

UTLAPPS_sfml_env(){
    SFML_ROOT="${UTL3RDP_APPS}/sfml"

    SFML_VER="SFML-2.3.2"
    SFML_DIR="${SFML_ROOT}/${SFML_VER}"

    #export PATH=${SFML_DIR}:${PATH}

}

UTLAPPS_sfml_root(){
    cmake .. CMAKE_INSTALL_PREFIX=`(cd .. && pwd)`.dist
    cmake .. -DCMAKE_INSTALL_PREFIX=../../SFML-2.3.2.dist
    
    apt-get install -y xorg-dev libgl1-mesa-dev libudev-dev libglew-dev libjpeg-dev libopenal-dev libsndfile-dev
}
