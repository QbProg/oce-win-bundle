cmake_minimum_required(VERSION 2.6)

set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "" FORCE)
PROJECT(oce_depends)
SET(CMAKE_DEBUG_POSTFIX "d")
SET(FT_DIR ${CMAKE_SOURCE_DIR}/libs/freetype-2.4.4)
SET(FTGL_DIR ${CMAKE_SOURCE_DIR}/libs/ftgl-2.1.3~rc5)
SET(GL2PS_DIR ${CMAKE_SOURCE_DIR}/libs/gl2ps-1.3.5-source)

SET(INSTALL_DIR "C:/testinstall")

SUBDIRS(freetype.cmake)
SUBDIRS(ftgl.cmake)
SUBDIRS(gl2ps.cmake)


FILE(GLOB_RECURSE freetype_headers "${FT_DIR}/include/*.*")

INSTALL(FILES ${freetype_headers}
	DESTINATION ${INSTALL_DIR}/freetype COMPONENT Development )

