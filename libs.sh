utl_lib_joinArray() {
    local IFS="$1"; shift; echo "$*";
}

utl_lib_joinLines() {
    awk -v sep="$1" '{printf "%s%s", s, $0; s = sep}'
}

utl_lib_findJars()
{
    for dir do
        find "$dir" -name '*.jar' -print
    done | utl_lib_joinLines ":"
}

utl_lib_check(){
    read -p "Are you sure? " -n 1 -r;
    echo # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]] ; then
        local l=""
    fi
}

utl_lib_checkOs(){
    # OS specific support.  $var _must_ be set to either true or false.
    os400=false
    linux=false
    darwin=false
    cygwin=false
    mingwin=false
    case "`uname`" in
        Linux*) linux=true;;
        OS400*) os400=true;;
        Darwin*) darwin=true;;
        CYGWIN*) cygwin=true;;
        MINGW32*) mingwin=true;;
    esac
}

utl_lib_parseArgs(){
   until [ -z "$1" ] ; do {
      local arg="${1}"; shift

      #echo "Processing parameter of: ${arg} ";
      if [ "${arg:0:1}" = '-' ]; then
         tmp="${arg:1}"     # Strip off leading -

         local argName=${tmp%%=*}  # Extract name.
         local argValue=${tmp##*=}   # Extract value.

         #echo "Parameter: '$argName', value: '$argValue'"
         eval ${argName}=\"${argValue}\"
      fi
   } done;
}

