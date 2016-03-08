UTLAPPS_blender_init(){
  alias blender-env='UTLAPPS_blender_env'
  alias blender-alias='alias | grep blender'
}

UTLAPPS_blender_env(){
   export BLENDER_VERSION="blender-2.78a-linux-glibc211-x86_64"
   export BLENDER_ROOT="${UTL3RDP_APPS}/blender/${BLENDER_VERSION}"
   export PATH=${BLENDER_ROOT}:${PATH}
}
