#/bin/bash

UTLAPPS_clion_env(){
   appName="Clion"

   export CLION_VERSION="clion-1.0.4"
   export CLION_ROOT="${UTL3RDP_APPS}/clion"
   export CLION_HOME="${CLION_ROOT}/${CLION_VERSION}"
}

UTLAPPS_clion_init(){
   UTLAPPS_clion_env

   alias clion-alias='alias | grep clion'
   alias clion-setup='UTLAPPS_clion_setup'
   alias clion-start='${CLION_HOME}/bin/clion.sh &'

}

UTLAPPS_clion_setup(){
   UTLAPPS_clion_env
   UTLAPPS_clion_install
   bash -xe ${CLION_SETUP_FILE}
}

UTLAPPS_clion_install(){
   echo "${appName}"

   local vname=${CLION_VERSION}

   local dname_setup="/tmp/setup/${vname}"
   local dname_clion="${CLION_ROOT}/${vname}"

   mkdir -p ${dname_setup}

   local fname_sed="${dname_setup}/${appName}_${vname}.sed"
   local fname_setup="${dname_setup}/${appName}_${vname}.sh"

   export CLION_SETUP_FILE="${fname_setup}"

   cat > ${fname_sed} << E_O_F
s@^.*idea.log.path=.*@idea.log.path=\${idea.home}/.${appName}/system/log@g
s@^.*idea.config.path=.*@idea.config.path=\${idea.home}/.${appName}/config@g
s@^.*idea.system.path=.*@idea.system.path=\${idea.home}/.${appName}/system@g
s@^.*idea.plugins.path=.*@idea.plugins.path=\${idea.home}/.${appName}/config/plugins@g
E_O_F

   local fname_vmoptions="${dname_setup}/clion_${vname}.vmoptions"

cat <<"E_O_F"> ${fname_vmoptions}
-Xms1024m
-Xmx2048m
-XX:MaxPermSize=512m
-XX:ReservedCodeCacheSize=128m
-XX:MaxGCPauseMillis=10
-XX:MaxHeapFreeRatio=70
-XX:+UseConcMarkSweepGC
-XX:+CMSIncrementalPacing
-ea
E_O_F

cat <<E_O_F> ${fname_setup}
#/bin/bash
clion_setup(){
   local fname_sed="${fname_sed}"
   local fname_vmoptions="${fname_vmoptions}"

   local fname_prop_target="${dname_clion}/bin/idea.properties"
   local fname_prop_setup="${dname_setup}/idea.${vname}.properties"

   if ! [ -e \${fname_prop_setup} ] ; then
      cp \${fname_prop_target} \${fname_prop_setup}
   fi

   cp \${fname_prop_setup} \${fname_prop_target}
   sed -f \${fname_sed} -i \${fname_prop_target}

   cp \${fname_vmoptions} ${dname_clion}/bin/idea.vmoptions
   cp \${fname_vmoptions} ${dname_clion}/bin/idea64.vmoptions

}

clion_setup

E_O_F

}
