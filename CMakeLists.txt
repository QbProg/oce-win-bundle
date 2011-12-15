cmake_minimum_required(VERSION 2.6)

PROJECT(oce-win-bundle)
SET(CMAKE_DEBUG_POSTFIX "d")
SET(FT_DIR ${CMAKE_SOURCE_DIR}/libs/freetype)
SET(FTGL_DIR ${CMAKE_SOURCE_DIR}/libs/ftgl)
SET(GL2PS_DIR ${CMAKE_SOURCE_DIR}/libs/gl2ps)
SET(FREEIMAGE_DIR ${CMAKE_SOURCE_DIR}/libs/FreeImage)
SET(LIBPNG_DIR ${CMAKE_SOURCE_DIR}/libs/FreeImage/Source/LibPNG/)
SET(ZLIB_DIR ${CMAKE_SOURCE_DIR}/libs/FreeImage/Source/zlib/)

IF (${CMAKE_SIZEOF_VOID_P} MATCHES "8") # It is 64bit, otherwise 32 bit systems match 4
	ADD_DEFINITIONS(-D_OCC64)
	SET(BIT 64)
ELSE (${CMAKE_SIZEOF_VOID_P} MATCHES "8")
  SET(BIT 32)
ENDIF(${CMAKE_SIZEOF_VOID_P} MATCHES "8")


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

SET(INSTALL_DIR_BITS ${INSTALL_DIR}/Win${BIT}/)

SUBDIRS(freetype.cmake)
SUBDIRS(ftgl.cmake)
SUBDIRS(gl2ps.cmake)
SUBDIRS(freeimage.cmake)

INSTALL(FILES ./oce-bundle-root.empty DESTINATION ${INSTALL_DIR})
