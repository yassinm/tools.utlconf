UTLAPPS_qt_init(){
   local empty
}

UTLAPPS_qt_env(){
    QT_ROOT="${UTL3RDP_APPS}/qt"

    QTCREATOR_VER="qtcreator-3.6.1"
    QTCREATOR_DIR="${QT_ROOT}/qtcreator/${QTCREATOR_VER}"

    export PATH=${QTCREATOR_DIR}/bin:${PATH}
}
