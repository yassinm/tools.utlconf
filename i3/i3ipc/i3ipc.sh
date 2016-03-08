UTLI3IPC_init(){
  alias i3ipc-conf="UTLI3IPC_conf"
  alias i3ipc-dev="UTLI3IPC_dev"
}

UTLI3IPC_dev(){
  source $HOME/.virtualenvs/i3ipc/bin/activate
  cd $HOME/work/_utl/utl-conf/i3/i3ipc
}

UTLI3IPC_conf(){
  (
    mkdir -p $HOME/.virtualenvs
    cd $HOME/.virtualenvs && virtualenv -p /usr/bin/python2.7 i3ipc
  )
}
