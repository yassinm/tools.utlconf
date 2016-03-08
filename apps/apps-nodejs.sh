UTLAPPS_nodejs_init(){
  #  alias nodejs-env='UTLAPPS_nodejs_env'
  #  alias nodejs-proxy='UTLAPPS_nodejs_proxy'

  alias nodejs-6x='UTLAPPS_nodejs_6x'
  alias nodejs-7x='UTLAPPS_nodejs_7x'

  alias nodejs-conf='UTLAPPS_nodejs_conf'
  alias nodejs-alias='alias | grep nodejs'
}


UTLAPPS_nodejs_6x(){
  NODEJS_VERSION="node-v6.10.0-linux-x64"
  UTLAPPS_nodejs_env
}


UTLAPPS_nodejs_7x(){
  NODEJS_VERSION="node-v7.9.0-linux-x64"
  UTLAPPS_nodejs_env
}

UTLAPPS_nodejs_env(){
    utl_init_env

    YARN_VERSION="yarn-v0.22.0"

    NODEJS_ROOT="${UTL3RDP_DEV}/nodejs"
    NODEJS_HOME="${NODEJS_ROOT}/${NODEJS_VERSION}"

    export PATH=./node_modules/.bin:${NODEJS_HOME}/bin:${NODEJS_ROOT}/${YARN_VERSION}/bin:${PATH}

}

UTLAPPS_nodejs_conf(){
   UTLAPPS_nodejs_env

   #to see all configs
   #npm -g config ls -l

   npm -g config set cache ${NODEJS_HOME}/.npm

}

UTLAPPS_nodejs_unset(){
    unset http_proxy
    unset https_proxy

    npm config delete proxy
    npm config delete http-proxy
    npm config delete https-proxy
    npm config delete http_proxy
    npm config delete https_proxy
}

UTLAPPS_nodejs_proxy(){
    UTLAPPS_nodejs_unset

    if [ -z "${UTL_PROXY_HTTP_HOST}" ] ; then
        return
    fi

    npm config set proxy http://${UTL_PROXY_HTTP_HOST}:${UTL_PROXY_HTTP_PORT}
    npm config set https-proxy http://${UTL_PROXY_HTTPS_HOST}:${UTL_PROXY_HTTPS_PORT}

cat << E_O_F > ~/.bowerrc
{
    "proxy":"http://${UTL_PROXY_HTTP_HOST}:${UTL_PROXY_HTTP_PORT}",
    "https-proxy":"http://${UTL_PROXY_HTTPS_HOST}:${UTL_PROXY_HTTPS_PORT}"
}
E_O_F

}


UTLAPPS_nodered_env(){
   NODERED_ROOT="${UTL3RDP_APPS}/node-red"
   alias node-red='node-red -u ${NODERED_ROOT}/.nodered '
}
