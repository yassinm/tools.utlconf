#/bin/bash

UTLAPPS_gradle_init(){
    #UTLAPPS_gradle_latest

    alias gradle-alias='alias | grep gradle'
    alias gradle-daemon='UTLAPPS_gradle_daemon'

    alias gradle-proxy='UTLAPPS_gradle_proxy'
    alias gradle-noproxy='UTLAPPS_gradle_noproxy'

    alias gradle-3-1="UTLAPPS_gradle_version gradle-3.1"
    alias gradle-3-3="UTLAPPS_gradle_version gradle-3.3"
    alias gradle-4-0="UTLAPPS_gradle_version gradle-4.0"

    alias gradle-build='gradle -x test build'
    alias gradle-tests='gradle test -a --rerun-tasks --tests'

    #def gitSha = 'git rev-parse --short HEAD'.execute().text.trim()
    #def gitCommitCount = 'git rev-list HEAD --count'.execute().text.trim()

}

UTLAPPS_gradle_env(){
    GRADLE_ROOT="${UTL3RDP_DEV}/gradle"
}

UTLAPPS_gradle_latest(){
    UTLAPPS_gradle_version gradle-4.0
}

UTLAPPS_gradle_version(){
    local lVersion="${1}"
    if [ -z "${lVersion}" ] ; then
        echo you must pass version for configurations; return
    fi

    UTLAPPS_gradle_env
    GRADLE_VERSION="${lVersion}"
    export PATH=${GRADLE_ROOT}/${GRADLE_VERSION}/bin:${PATH}
}

UTLAPPS_gradle_noproxy(){
cat <<E_O_F> ~/.gradle/gradle.properties
org.gradle.daemon=true
E_O_F

}

UTLAPPS_gradle_proxy(){
    #UTLAPPS_gradle_noproxy

    #unset http_proxy
    #unset https_proxy

mkdir -p ~/.gradle
cat <<E_O_F>> ~/.gradle/gradle.properties

systemProp.http.proxyPort=${UTL_PROXY_HTTP_PORT}
systemProp.http.proxyHost=${UTL_PROXY_HTTP_HOST}

systemProp.https.proxyPort=${UTL_PROXY_HTTPS_PORT}
systemProp.https.proxyHost=${UTL_PROXY_HTTPS_HOST}

E_O_F

}
