#!/bin/bash

initConf(){
	local bashFile="${HOME}/.bashrc"
	
	if [ -e ${bashFile} ] ; then
		sed -i '\:#utlIniStart:,\:#utlIniEnd:d' ${bashFile}
	fi

cat <<"E_O_F">>${bashFile}

#utlIniStart
. ${HOME}/work/_utl/utl-conf/conf.sh
#utlIniEnd
E_O_F
}

if [ "${1}" = "init" ] ; then
  initConf
fi
