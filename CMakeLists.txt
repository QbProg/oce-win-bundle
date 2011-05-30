cmake_minimum_required(VERSION 2.6)

set(CMAKE_CONFIGURATION_TYPES "Debug;RelWithDebInfo" CACHE STRING "" FORCE)
PROJECT(oce-win-bundle)
SET(CMAKE_DEBUG_POSTFIX "d")
SET(FT_DIR ${CMAKE_SOURCE_DIR}/libs/freetype-2.4.4)
SET(FTGL_DIR ${CMAKE_SOURCE_DIR}/libs/ftgl-2.1.3~rc5)
SET(GL2PS_DIR ${CMAKE_SOURCE_DIR}/libs/gl2ps-1.3.5-source)
SET(FREEIMAGE_DIR ${CMAKE_SOURCE_DIR}/libs/FreeImage)
SET(LIBPNG_DIR ${CMAKE_SOURCE_DIR}/libs/FreeImage/Source/LibPNG/)
SET(ZLIB_DIR ${CMAKE_SOURCE_DIR}/libs/FreeImage/Source/zlib/)



IF( NOT DEFINED INSTALL_DIR )
	IF( WIN32 )
		SET(INSTALL_DIR "c:/oce-win-bundle")
	ENDIF( WIN32 )
ENDIF( NOT DEFINED INSTALL_DIR )

SET( INSTALL_DIR ${INSTALL_DIR} CACHE
	PATH "Install prefix prepended to target to create install location" )
SET( CMAKE_INSTALL_PREFIX "${INSTALL_DIR} " CACHE INTERNAL "Prefix
	prepended to install directories if target destination is not absolute,
	immutable" FORCE )

SUBDIRS(freetype.cmake)
SUBDIRS(ftgl.cmake)
SUBDIRS(gl2ps.cmake)
SUBDIRS(freeimage.cmake)

INSTALL(FILES ./oce-bundle-root.empty DESTINATION ${INSTALL_DIR})