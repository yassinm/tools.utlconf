UTLAPPS_jdk_init(){
  UTLAPPS_jdk_8_latest

  alias jdk-8-latest="UTLAPPS_jdk_8_latest"
  alias jdk-7-latest="UTLAPPS_jdk_7_latest"

  alias jdk-9-ea="UTLAPPS_jdk_9_ea"
  alias jdk-alias="alias | grep jdk"
}

#-------------------------------------------------------------------------------

UTLAPPS_jdk_7_latest(){
   export JAVA_HOME="${UTL3RDP_DEV}/java/jdk-7-latest"
   export JRE_HOME="${JAVA_HOME}/jre"
   export PATH=${JAVA_HOME}/bin:${PATH}
}

UTLAPPS_jdk_8_latest(){
   export JAVA_HOME="${UTL3RDP_DEV}/java/jdk-8-latest"
   export JRE_HOME="${JAVA_HOME}/jre"
   export PATH=${JAVA_HOME}/bin:${PATH}
}

UTLAPPS_jdk_9_ea(){
   export JAVA_HOME="${UTL3RDP_DEV}/java/jdk-9-ea+129_linux-x64"
   export JRE_HOME="${JAVA_HOME}/jre"
   export PATH=${JAVA_HOME}/bin:${PATH}
}
