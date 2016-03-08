UTLDOCKER_drupal_init(){
    alias drupal-stop='UTLDOCKER_drupal_stop'
    alias drupal-start='UTLDOCKER_drupal_start'
    alias drupal-create='UTLDOCKER_drupal_create'
    alias drupal-remove='UTLDOCKER_drupal_remove'
}

UTLDOCKER_drupal_env(){
    DRUPAL_DB000="db000"
    DRUPAL_SITE000="site000"
    DRUPAL_SITE001="site001"

    DRUPAL_VERSION="drupal-8.1.6"

    DRUPAL_DB_USER="drupalu"
    DRUPAL_DB_NAME="drupaldb"
    DRUPAL_DB_PASSWD="X#Cqyb!U044z3Ga&kD"

    DRUPAL_MYSQL_USER="drupalu"
    DRUPAL_MYSQL_PASSWD="X#Cqyb!U044z3Ga&kD"

    DRUPAL_ROOT="${UTLDOCKER_3RDP_APPS}/drupal"

    DRUPAL_SITES="/mnt/data/sites"
    DRUPAL_SITES_ARCHIVE="${DRUPAL_ROOT}/backup"

}

UTLDOCKER_drupal_start(){
    docker start ${DRUPAL_DB000}
    docker start ${DRUPAL_SITE000}
    docker start ${DRUPAL_SITE001}
}

UTLDOCKER_drupal_remove(){
    docker rm ${DRUPAL_SITE000}
    docker rm ${DRUPAL_SITE001}
    docker rm ${DRUPAL_DB000}
}

UTLDOCKER_drupal_stop(){
    docker stop ${DRUPAL_DB000}
    docker stop ${DRUPAL_SITE000}
    docker stop ${DRUPAL_SITE001}
}

UTLDOCKER_drupal_create(){
    UTLDOCKER_drupal_create_db ${DRUPAL_DB000}
    UTLDOCKER_drupal_create_site ${DRUPAL_SITE000} 9000
    UTLDOCKER_drupal_create_site ${DRUPAL_SITE001} 9001
}

UTLDOCKER_drupal_create_db(){
    #set -x

    local dbName=${1}
    local dbLoc="${DRUPAL_SITES}/${dbName}"

    if [ -z ${dbName} ] ; then
       echo "dbName must be provided" ; return
    fi

    docker create \
        --name=${dbName} \
        -e MYSQL_ROOT_PASSWORD=${DRUPAL_DB_PASSWD} \
        -v "${DRUPAL_ROOT}/scripts":/mnt/scripts \
        -v "${dbLoc}":/var/lib/mysql mariadb:latest

    #set +x
}

UTLDOCKER_drupal_create_site(){
    set -x

    local siteName="${1}"
    if [ -z "${siteName}" ] ; then
       echo "siteName must be provided" ; return
    fi

    local portName="${2}"
    if [ -z "${portName}" ] ; then
       echo "portName must be provided" ; return
    fi

    local siteLoc="${DRUPAL_SITES}/${siteName}"
    if [ -e "${siteLoc}" ] ; then
        echo "${siteLoc} already exists"
    else
        cp -a ${DRUPAL_ROOT}/${DRUPAL_VERSION} ${DRUPAL_SITES}/${siteName}
    fi

    docker create \
        -p 127.0.0.1:${portName}:80 \
        --name=${siteName} \
        --link ${DRUPAL_DB000}:mysql \
        -v "${siteLoc}":/var/www/html \
        ymo/drupal:8.1.5

    set +x

}

UTLDOCKER_drupal_utlmisc(){
    siteName
    chown -R www-data:www-data sites/site00{0,1}/{sites,themes}/

    #docker run -it --rm -e MYSQL_ROOT_PASSWORD=admin000 mysql bash

    #-e MYSQL_DATABASE=${DRUPAL_DB_NAME} \
    #-e MYSQL_USER=${DRUPAL_MYSQL_USER} \
    #-e MYSQL_PASSWORD=${DRUPAL_MYSQL_PASSWD} \

    #docker rm $(docker ps -q -f status=exited)

    UTLDOCKER_drupal_stop
    UTLDOCKER_drupal_create
    UTLDOCKER_drupal_start

    docker ps -a
    docker rm $(docker ps -a -q)

    docker build -t ymo/drupal:8.1.5 .

    docker exec -it ${DRUPAL_SITE001} /bin/bash

    docker exec -it ${DRUPAL_DB000} /bin/bash -c "/mnt/scripts/site/site.init.sh"
    docker exec -it ${DRUPAL_DB000} /usr/bin/mysql -uroot -p"${DRUPAL_DB_PASSWD}" #${DRUPAL_DB000}

}
