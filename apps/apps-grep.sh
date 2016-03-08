#/bin/bash

UTLAPPS_grep_init(){
   alias grep-alias='alias | grep "grep-"'
   alias grep-tools='UTLAPPS_grep_tools'
}

UTLAPPS_grep_tools(){
   alias grep-as='grep -nr --include "*.as" '
   alias grep-java='grep -nr --include "*.java" '
   alias grep-js='grep -nr --include "*.js" --include "*.html" '
   alias grep-xml='grep -nr --include "*.html" --include "*.xml" '

   alias grep-cpp='UTLAPPS_grep_cpp_cc'
   alias grep-cpp-h='UTLAPPS_grep_cpp_hh'
   alias grep-cpp-all='UTLAPPS_grep_cpp_all'
}

UTLAPPS_grep_cpp_hh(){
   grep -nr --include "*.h" --include "*.hh" --include "*.H" ${@}
}

UTLAPPS_grep_cpp_cc(){
   grep -nr --include "*.c" --include "*.cpp" --include "*.cc" --include "*.C" ${@}
}

UTLAPPS_grep_cpp_all(){
   grep -nr --include "*.c" --include "*.cpp" --include "*.cc" --include "*.C" \
      --include "*.h" --include "*.hh" --include "*.H" ${@}
}


