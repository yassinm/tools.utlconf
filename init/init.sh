UTLINIT_init(){
    alias utlinit-bashrc="UTLINIT_bashrc"
}

UTLINIT_bashrc(){
  utl_init_env

  if [ -e ${UTLCONF_BASHRC} ] ; then
    sed -i '\:#utlInitStart:,\:#utlInitEnd:d' ${UTLCONF_BASHRC}
  fi

cat <<E_O_F>>${UTLCONF_BASHRC}
#utlInitStart
. ${UTLCONF}/conf.sh
#utlInitEnd
E_O_F

}
