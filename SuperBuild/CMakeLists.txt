cmake_minimum_required(VERSION 2.8.2)

project(oce-superbuild)

include(CTest)
include(ExternalProject)

set(ep_base "${CMAKE_BINARY_DIR}/ExternalProjects")
set_property(DIRECTORY PROPERTY EP_BASE ${ep_base})

option(BUILD_SHARED_LIBS "Build shared libraries" ON)
option(BUILD_TESTING "Enable testing during builds" OFF)

set(ep_install_dir ${ep_base}/Install)
set(ep_build_dir ${ep_base}/Build)
set(ep_build_shared_libs ${BUILD_SHARED_LIBS})
set(ep_build_testing ${BUILD_TESTING})

if (${CMAKE_SIZEOF_VOID_P} MATCHES "8") # It is 64bit, otherwise 32 bit systems match 4
    set(BIT 64)
else ()
    set(BIT 32)
endif()

if (WIN32)
    set(ep_install_dir_bits "${ep_install_dir}/Win${BIT}")
else ()
    set(ep_install_dir_bits "${ep_install_dir}")
endif ()

# Set the default build type---this will affect all libraries and
# applications
#
if (NOT CMAKE_CONFIGURATION_TYPES)
    set(build_type "")
    if(CMAKE_BUILD_TYPE)
        set(build_type "${CMAKE_BUILD_TYPE}")
    else()
        set(build_type "Release")
    endif()
    set( CMAKE_BUILD_TYPE ${build_type} CACHE STRING "Choose the type of build, options are: None(CMAKE_CXX_FLAGS or CMAKE_C_FLAGS used) Debug Release RelWithDebInfo MinSizeRel." FORCE )
endif()

set(ep_common_args
  -DBUILD_SHARED_LIBS:BOOL=${ep_build_shared_libs}
  -DCMAKE_INSTALL_PREFIX:PATH=${ep_install_dir}
  -DBUILD_TESTING:BOOL=${ep_build_testing}
  -DBUILD_EXAMPLES:BOOL=OFF
  -DCMAKE_BUILD_TYPE:BOOL=${build_type}
  -DOCE_WIN_BUNDLE_INSTALL_DIR:PATH=${ep_install_dir}
  -DOCE_WIN_BUNDLE_INSTALL_DIR_BITS:PATH=${ep_install_dir_bits}
)

# Compute -G arg for configuring external projects with the same CMake generator:
#
if(CMAKE_EXTRA_GENERATOR)
  set(gen "${CMAKE_EXTRA_GENERATOR} - ${CMAKE_GENERATOR}")
else()
  set(gen "${CMAKE_GENERATOR}")
endif()

############################################################################
# FreeType
#
IF(NOT DEFINED FREETYPE_DIR)
    set(proj freetype)
    ExternalProject_Add(${proj}
      URL http://download.savannah.gnu.org/releases/freetype/freetype-2.4.10.tar.gz
      URL_MD5 4f255c6ee5d5cc2b5c3d423a07386fcb
      CMAKE_GENERATOR ${gen}
      CMAKE_ARGS
        ${ep_common_args}
        -DFT_DIR:STRING=${ep_base}/Source/${proj}
    )

    add_custom_command(
      OUTPUT ${ep_base}/Source/${proj}/CMakeLists.txt
      COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/../${proj}.cmake/CMakeLists.txt ${ep_base}/Source/${proj}/CMakeLists.txt
      DEPENDS ${CMAKE_SOURCE_DIR}/../${proj}.cmake/CMakeLists.txt
      )
    add_custom_command(
      OUTPUT ${ep_base}/Source/${proj}/freetype.def
      COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/../${proj}.cmake/freetype.def ${ep_base}/Source/${proj}/freetype.def
      DEPENDS ${CMAKE_SOURCE_DIR}/../${proj}.cmake/freetype.def
      )
    ExternalProject_Add_Step(${proj} update_build_system
      COMMENT "Updating build system"
      DEPENDS ${ep_base}/Source/${proj}/CMakeLists.txt ${ep_base}/Source/${proj}/freetype.def
      DEPENDERS configure
      ALWAYS OFF
      )

    set(FREETYPE_DIR "${ep_build_dir}/${proj}")

ENDIF()

############################################################################
# FreeImage
#
IF(NOT DEFINED FREEIMAGE_DIR)
    set(proj FreeImage)
    ExternalProject_Add(${proj}
      URL http://sourceforge.net/projects/freeimage/files/Source%20Distribution/3.15.4/FreeImage3154.zip/download
      URL_MD5 9f9a3b2c3c1b4fd24fe479e8aaee86b1
      CMAKE_GENERATOR ${gen}
      CMAKE_ARGS
        ${ep_common_args}
        -DFREEIMAGE_DIR:STRING=${ep_base}/Source/${proj}
    )

    add_custom_command(
      OUTPUT ${ep_base}/Source/${proj}/CMakeLists.txt
      COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/../${proj}.cmake/CMakeLists.txt ${ep_base}/Source/${proj}/CMakeLists.txt
      DEPENDS ${CMAKE_SOURCE_DIR}/../${proj}.cmake/CMakeLists.txt
      )
    ExternalProject_Add_Step(${proj} update_build_system
      COMMENT "Updating build system"
      DEPENDS ${ep_base}/Source/${proj}/CMakeLists.txt
      DEPENDERS configure
      ALWAYS OFF
      )

    set(FREEIMAGE_DIR "${ep_build_dir}/${proj}")

ENDIF()

############################################################################
# gl2ps
#
IF(NOT DEFINED GL2PS_DIR)
    set(proj gl2ps)
    ExternalProject_Add(${proj}
      URL http://geuz.org/gl2ps/src/gl2ps-1.3.8.tgz
      URL_MD5 05ae306fdad00a24ffcabf47d8ae363e
      PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/../${proj}.cmake/CMakeLists.txt ${ep_base}/Source/${proj}/CMakeLists.txt
      UPDATE_COMMAND ""
      CMAKE_GENERATOR ${gen}
      CMAKE_ARGS
        ${ep_common_args}
        -DGL2PS_DIR:STRING=${ep_base}/Source/${proj}
        -DFREEIMAGE_DIR:STRING=${ep_base}/Source/${proj}
        -DLIBPNG_DIR:STRING=${ep_base}/Source/FreeImage/Source/LibPNG
        -DZLIB_DIR:STRING=${ep_base}/Source/FreeImage/Source/ZLib
    )

    set(GL2PS_DIR "${ep_build_dir}/${proj}")

ENDIF()

############################################################################
# OCE
#

ExternalProject_Add(oce
  URL https://github.com/tpaviot/oce/archive/OCE-0.12.tar.gz
  URL_MD5 a49be79576ef421de28a28d51e60a009
  CMAKE_GENERATOR ${gen}
  CMAKE_ARGS
    ${ep_common_args}
    -DOCE_INSTALL_PREFIX:PATH=${ep_install_dir}
    -DFREETYPE_DIR:FILEPATH=${FREETYPE_DIR}
    -DFREEIMAGE_DIR:FILEPATH=${FREEIMAGE_DIR}
    -DFTGL_DIR:FILEPATH=${FTGL_DIR}
    -DGL2PS_DIR:FILEPATH=${GL2PS_DIR}
    -DOCE_DRAW:BOOL=ON
    -DOCE_MULTITHREAD_LIBRARY:STRING=NONE
    -DOCE_WITH_FREEIMAGE:BOOL=ON
    -DOCE_WITH_GL2PS:BOOL=ON
  DEPENDS
    freetype FreeImage gl2ps
)
