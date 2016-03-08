UTLAPPS_gerrit_init(){
    alias gerrit-start='UTLAPPS_gerrit_start'
    alias gerrit-stop='UTLAPPS_gerrit_stop'
    alias gerrit-restart='UTLAPPS_gerrit_restart'
    alias gerrit-status='UTLAPPS_gerrit_status'
}

UTLAPPS_gerrit_env(){
    GERRIT_ROOT="${UTL3RDP_APPS}/gerrit"

    GERRIT_VER="gerrit-2.12.2"
    GERRIT_DATA="${GERRIT_ROOT}/data"
    GERRIT_WAR="${GERRIT_ROOT}/${GERRIT_VER}.war"
    GERRIT_OPTS="-Djava.net.preferIPv4Stack=true -Djava.net.preferIPv4Addresses=true "

    export JAVA_OPTIONS="${GERRIT_OPTS}"

    #GERRIT_DIR="${GERRIT_ROOT}/${GERRIT_VER}"
    #export PATH=${GERRIT_DIR}:${PATH}

}

UTLAPPS_gerrit_status(){
    UTLAPPS_gerrit_env
    ${GERRIT_DATA}/bin/gerrit.sh status
}

UTLAPPS_gerrit_start(){
    UTLAPPS_gerrit_env
    ${GERRIT_DATA}/bin/gerrit.sh start
}

UTLAPPS_gerrit_stop(){
    UTLAPPS_gerrit_env
    ${GERRIT_DATA}/bin/gerrit.sh stop
}

UTLAPPS_gerrit_restart(){
    set -x
    UTLAPPS_gerrit_env
    bash -x ${GERRIT_DATA}/bin/gerrit.sh stop
    bash -x ${GERRIT_DATA}/bin/gerrit.sh start
    set +x
}

UTLAPPS_gerrit_conf(){
    java -jar ${GERRIT_WAR} init --batch -d ${GERRIT_DATA}
}
