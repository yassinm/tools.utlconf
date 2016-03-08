UTLAPPS_jenkins_init(){
    UTLAPPS_jenkins_env
    alias jenkins-2_7='UTLAPPS_jenkins_2_7'
    alias jenkins-conf='UTLAPPS_jenkins_conf ${UTL3RDP_APPS}'
}

UTLAPPS_jenkins_env(){
    JENKINS_VER="jenkins-2.7.2"
    JENKINS_ROOT="${UTL3RDP_APPS}/jenkins"
}

UTLAPPS_jenkins_2_7(){
    (
        cd ${JENKINS_ROOT}
        export JENKINS_HOME="${JENKINS_ROOT}/data/${JENKINS_VER}"
        java -jar ${JENKINS_VER}.war -noKeyAuth
    )
}
