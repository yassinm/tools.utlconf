UTLDOCKER_wordpress_init(){
    UTLDOCKER_wordpress_env

    alias wordpress-stop='UTLDOCKER_wordpress_stop'
    alias wordpress-start='UTLDOCKER_wordpress_start'
    alias wordpress-create='UTLDOCKER_wordpress_create'
}

UTLDOCKER_wordpress_env(){
    WORDPRESS_ROOT="${UTLDOCKER_3RDP_APPS}/wordpress"

    WORDPRESS_WWW="wordpress-www"
    WORDPRESS_DATA="wordpress-data"

    WORDPRESS_SITE="${WORDPRESS_ROOT}/site.000"

}

UTLDOCKER_wordpress_start(){
    docker start ${WORDPRESS_DATA}
    docker start ${WORDPRESS_WWW}
}

UTLDOCKER_wordpress_stop(){
    docker stop ${WORDPRESS_WWW}  && docker rm ${WORDPRESS_WWW}
    docker stop ${WORDPRESS_DATA} && docker rm ${WORDPRESS_DATA}
}

UTLDOCKER_wordpress_test(){
    #docker run -it --rm -e MYSQL_ROOT_PASSWORD=admin000 mysql bash

    UTLDOCKER_wordpress_stop
    UTLDOCKER_wordpress_create
    UTLDOCKER_wordpress_start

    docker ps -a

    # X#Cqyb!U044z3Ga&kD

    return

    docker run -it --rm  \
        --name=${WORDPRESS_DATA} \
        -e MYSQL_DATABASE=wordpress \
        -e MYSQL_ROOT_PASSWORD=admin000 \
        -v "${WORDPRESS_ROOT}/data":/var/lib/mysql mariadb bash

}

UTLDOCKER_wordpress_create(){

    docker create \
        --name=${WORDPRESS_DATA} \
        -e MYSQL_DATABASE=wordpress \
        -e MYSQL_ROOT_PASSWORD=admin000 \
        -v "${WORDPRESS_SITE}/data":/var/lib/mysql mariadb:latest

    #return

    docker create \
        -p 127.0.0.1:8888:80 \
        --name=${WORDPRESS_WWW} \
        --link ${WORDPRESS_DATA}:mysql \
        -e WORDPRESS_DB_PASSWORD=admin000 \
        -v "${WORDPRESS_SITE}/html":/var/www/html wordpress:latest

}
