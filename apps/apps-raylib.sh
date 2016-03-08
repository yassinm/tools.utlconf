UTLAPPS_raylib_init(){
    alias raylib-env='UTLAPPS_raylib_env'
    alias raylib-alias='alias | grep raylib'
}

UTLAPPS_raylib_env(){
    utl_init_env
}

UTLAPPS_raylib_release(){
  #main lib
  PREFIX=`cd .. && pwd`.dist make install
  
  #exmaples
  RAYLIB_PATH=`cd .. && pwd` make PLATFORM=PLATFORM_DESKTOP 

# It installs generated and needed files to compile projects using raylib.
# The installation works manually.
# TODO: add other platforms.
install :
	mkdir -p $(PREFIX)/lib $(PREFIX)/include
	cp --update raylib.h $(PREFIX)/include/raylib.h
	cp --update $(OUTPUT_PATH)/libraylib.a $(PREFIX)/lib/libraylib.a
}
