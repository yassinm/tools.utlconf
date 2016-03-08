#!/bin/sh

gitDiff(){
  local locPath=$(cd $(dirname "$1") && pwd)/$(basename "$1")
  local remPath=$(cd $(dirname "$2") && pwd)/$(basename "$2")

  if [ "${remPath}" = "/dev/null" ] ; then
    return
  fi

  #set -x
  /home/ymo/3rdp/dev/intellij/idea-latest/bin/idea.sh diff ${locPath} ${remPath}
  #set +x
}

gitMerge(){
  local locPath=$(cd $(dirname "$1") && pwd)/$(basename "$1")
  local remPath=$(cd $(dirname "$2") && pwd)/$(basename "$2")

  if [ "${remPath}" = "/dev/null" ] ; then
    return
  fi

  /home/ymo/3rdp/dev/intellij/idea-latest/bin/idea.sh merge ${locPath} ${remPath}
}


case "$1" in
    diff)
        shift
        gitDiff ${@}
        ;;
    merge)
        shift
        gitMerge ${@}
        ;;
    *)
        echo "Usage: $0 {diff|merge}"
        exit 2
esac
