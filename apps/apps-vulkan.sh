UTLAPPS_vulkan_init(){
    alias vulkan-env="UTLAPPS_vulkan_env"

    alias vulkan-test="UTLAPPS_vulkan_test"
    alias vulkan-glfw="UTLAPPS_vulkan_build"
    alias vulkan-build="UTLAPPS_vulkan_build"


}

UTLAPPS_vulkan_env(){
    VULKAN_VER="vulkan-1.0.57.0"

    VULKAN_GLFW="${VULKAN_ROOT}/glfw-3.2"
    VULKAN_ROOT="${UTL3RDP_GAMES}/vulkan"
    VULKAN_SDK="${VULKAN_ROOT}/${VULKAN_VER}"

    #export PATH=${VULKAN_DIR}:${PATH}
    export VK_LAYER_PATH="${VULKAN_SDK}/x86_64/etc/explicit_layer.d"
    export LD_LIBRARY_PATH="${VULKAN_SDK}/x86_64/lib:${LD_LIBRARY_PATH}"

}

UTLAPPS_vulkan_install(){
    #ubuntu 16 requires:
    apt-get install -y \
        libpthread-stubs0-dev \
        libxcb1-dev \
        libglm-dev \
        graphviz \
        libxcb-dri3-0 \
        libxcb-present0 \
        libpciaccess0 \
        libpng-dev \
        libx11-dev \
        bison

}

UTLAPPS_vulkan_build(){
    UTLAPPS_vulkan_env

    (
        #THREADS=$(grep -c ^processor /proc/cpuinfo)

        mkdir -p ${VULKAN_GLFW}/build
        cd ${VULKAN_GLFW}/build
        cmake -DCMAKE_BUILD_TYPE:STRING=Debug \
            -DCMAKE_INSTALL_PREFIX=`(cd .. && pwd)`.dist ..
        make && make install

    )

}

UTLAPPS_vulkan_test(){
    UTLAPPS_vulkan_env

    (
        set -e
        #echo "\${PATH}_ll"

        mkdir -p cmake

        UTLAPPS_vulkan_xcb
        UTLAPPS_vulkan_sample

        rm -rf ./build
        mkdir -p ./build && cd ./build
        cmake -G "Unix Makefiles" \
            -DCMAKE_BUILD_TYPE=Debug \
            -DCMAKE_C_FLAGS_DEBUG="-g3 -gdwarf-2" \
            -DCMAKE_CXX_FLAGS_DEBUG="-g3 -gdwarf-2" \
            -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..

    )
}


UTLAPPS_vulkan_sample(){
cat << "E_O_F" > ./CMakeLists.txt
cmake_minimum_required(VERSION 2.8)
#

set (GLFW_PATH "/home/ymo/3rdp/apps/vulkan/glfw-3.2.dist")

set (glfw3_DIR "${GLFW_PATH}/lib/cmake/glfw3")
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake")

#message("glfw3_DIR = ${glfw3_DIR}")

find_package(XCB REQUIRED)
find_package(X11 REQUIRED)
find_package(glfw3 REQUIRED)

if (CMAKE_COMPILER_IS_GNUCC OR CMAKE_C_COMPILER_ID MATCHES "Clang")
    set(COMMON_COMPILE_FLAGS "-Wall -Wextra -Wno-unused-parameter -Wno-missing-field-initializers")
    set(COMMON_COMPILE_FLAGS "${COMMON_COMPILE_FLAGS} -fno-strict-aliasing -fno-builtin-memcmp")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c99 ${COMMON_COMPILE_FLAGS}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${COMMON_COMPILE_FLAGS}")
    if (UNIX)
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fvisibility=hidden")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fvisibility=hidden")
    endif()
endif()

set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DVK_PROTOTYPES")
set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DVK_PROTOTYPES")

if(WIN32)
   link_libraries(${XCB_LIBRARIES} vulkan-${MAJOR} png m)
elseif(UNIX)
   link_libraries(${XCB_LIBRARIES} ${X11_LIBRARIES} vulkan glfw png m )
else()
endif()

if(WIN32)
   set (LIBRARIES "vulkan-${MAJOR}")
elseif(UNIX)
   option(BUILD_WSI_XCB_SUPPORT "Build XCB WSI support" ON)
   option(BUILD_WSI_XLIB_SUPPORT "Build Xlib WSI support" ON)

   if (BUILD_WSI_XCB_SUPPORT)
       add_definitions(-DVK_USE_PLATFORM_XCB_KHR)
       set(DisplayServer Xcb)
   endif()

   if (BUILD_WSI_XLIB_SUPPORT)
       add_definitions(-DVK_USE_PLATFORM_XLIB_KHR)
       set(DisplayServer Xlib)
   endif()

   set (LIBRARIES "vulkan")
else()
endif()


E_O_F
}

UTLAPPS_vulkan_xcb(){
cat << "E_O_F" > ./cmake/FindXCB.cmake
    # - FindXCB
    #
    # Copyright (C) 2015 Valve Corporation

    find_package(PkgConfig)

    if(NOT XCB_FIND_COMPONENTS)
        set(XCB_FIND_COMPONENTS xcb)
    endif()

    include(FindPackageHandleStandardArgs)
    set(XCB_FOUND true)
    set(XCB_INCLUDE_DIRS "")
    set(XCB_LIBRARIES "")
    foreach(comp ${XCB_FIND_COMPONENTS})
        # component name
        string(TOUPPER ${comp} compname)
        string(REPLACE "-" "_" compname ${compname})
        # header name
        string(REPLACE "xcb-" "" headername xcb/${comp}.h)
        # library name
        set(libname ${comp})

        pkg_check_modules(PC_${comp} QUIET ${comp})

        find_path(${compname}_INCLUDE_DIR NAMES ${headername}
            HINTS
            ${PC_${comp}_INCLUDEDIR}
            ${PC_${comp}_INCLUDE_DIRS}
            )

        find_library(${compname}_LIBRARY NAMES ${libname}
            HINTS
            ${PC_${comp}_LIBDIR}
            ${PC_${comp}_LIBRARY_DIRS}
            )

        find_package_handle_standard_args(${comp}
            FOUND_VAR ${comp}_FOUND
            REQUIRED_VARS ${compname}_INCLUDE_DIR ${compname}_LIBRARY)
        mark_as_advanced(${compname}_INCLUDE_DIR ${compname}_LIBRARY)

        list(APPEND XCB_INCLUDE_DIRS ${${compname}_INCLUDE_DIR})
        list(APPEND XCB_LIBRARIES ${${compname}_LIBRARY})

        if(NOT ${comp}_FOUND)
            set(XCB_FOUND false)
        endif()
    endforeach()

    list(REMOVE_DUPLICATES XCB_INCLUDE_DIRS)
E_O_F
}
