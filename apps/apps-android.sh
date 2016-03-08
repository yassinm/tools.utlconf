UTLAPPS_android_init(){
    alias android-env="UTLDEV_android_env"
    alias android-studio='UTLDEV_android_latest'
}

UTLDEV_android_env(){
    #source ${UTLFILE}

    ANDROID_ROOT="${UTL3RDP_APPS}/android"
    ANDROID_SDK_DIR="${ANDROID_ROOT}/android-sdk"

    ANDROID_2_1="android-studio-ide-145.3360264"

    export PATH="${ANDROID_SDK_DIR}/tools:${ANDROID_SDK_DIR}/platform-tools:${PATH}"
}

UTLDEV_android_latest(){
    UTLDEV_android_env
    ${ANDROID_ROOT}/android-latest/bin/studio.sh &
}
