UTLAPPS_gitdebug_init(){
  local l
}

UTLAPPS_gitdebug_strace(){
  strace -f -e open -o ./strace.log 
  strace -f -e trace= -o ./strace.log 

  strace -f -o ./strace.log git clone localgit/htools-cli.git test-`date "+%s"`
}
