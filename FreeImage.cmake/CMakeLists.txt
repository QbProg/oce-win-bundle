####### FREEIMAGE
PROJECT(FreeImage)
ADD_DEFINITIONS("-D_CRT_SECURE_NO_DEPRECATE")
ADD_DEFINITIONS("-D_CRT_NONSTDC_NO_WARNINGS")
ADD_DEFINITIONS("-DFREEIMAGE_EXPORTS")
ADD_DEFINITIONS("-DHAVE_STDLIB_H")
ADD_DEFINITIONS("-DOPJ_EXPORTS")
ADD_DEFINITIONS("-DLIBRAW_BUILDLIB")

INCLUDE_DIRECTORIES(${LIBPNG_DIR})
INCLUDE_DIRECTORIES(${ZLIB_DIR})
INCLUDE_DIRECTORIES(${FREEIMAGE_DIR}/Source/)
INCLUDE_DIRECTORIES(${FREEIMAGE_DIR}/Source/librawlite)
INCLUDE_DIRECTORIES(${FREEIMAGE_DIR}/Source/OpenEXR/Imath)
INCLUDE_DIRECTORIES(${FREEIMAGE_DIR}/Source/OpenEXR/IlmImf)
INCLUDE_DIRECTORIES(${FREEIMAGE_DIR}/Source/OpenEXR/Iex)
INCLUDE_DIRECTORIES(${FREEIMAGE_DIR}/Source/OpenEXR/half)
INCLUDE_DIRECTORIES(${FREEIMAGE_DIR}/Source/OpenEXR/IlmThread)
INCLUDE_DIRECTORIES(${FREEIMAGE_DIR}/Source/OpenEXR/)

FILE(GLOB png_files ${LIBPNG_DIR}/*.c)
FILE(GLOB zlib_files ${ZLIB_DIR}/*.c)
FILE(GLOB deprecation_files ${FREEIMAGE_DIR}/Source/DeprecationManager/*.cpp)
FILE(GLOB freeimage_files ${FREEIMAGE_DIR}/Source/FreeImage/*.cpp)
FILE(GLOB freeimagelib_files ${FREEIMAGE_DIR}/Source/FreeImageLib/*.cpp)
FILE(GLOB libjpeg_files ${FREEIMAGE_DIR}/Source/LibJPEG/*.c)
FILE(GLOB libmng_files ${FREEIMAGE_DIR}/Source/LibMNG/*.c)
FILE(GLOB libopenjpeg_files ${FREEIMAGE_DIR}/Source/LibOpenJPEG/*.c)
FILE(GLOB_RECURSE libraw_files ${FREEIMAGE_DIR}/Source/LibRawLite/src/*.cpp)
FILE(GLOB libtiff_files ${FREEIMAGE_DIR}/Source/LibTIFF/*.c)
FILE(GLOB metadata_files ${FREEIMAGE_DIR}/Source/metadata/*.cpp)
FILE(GLOB_RECURSE openexr_files ${FREEIMAGE_DIR}/Source/openexr/*.cpp)

LIST(REMOVE_ITEM zlib_files "${ZLIB_DIR}/example.c")
LIST(REMOVE_ITEM zlib_files "${ZLIB_DIR}/minigzip.c")
LIST(REMOVE_ITEM zlib_files "${LIBPNG_DIR}/pngtest.c")
LIST(REMOVE_ITEM libjpeg_files "${FREEIMAGE_DIR}/Source/LibJPEG/jmemdos.c")
LIST(REMOVE_ITEM libjpeg_files "${FREEIMAGE_DIR}/Source/LibJPEG/jmemmac.c")
LIST(REMOVE_ITEM libjpeg_files "${FREEIMAGE_DIR}/Source/LibJPEG/example.c")
LIST(REMOVE_ITEM libtiff_files "${FREEIMAGE_DIR}/Source/LibTIFF/tif_unix.c")
LIST(REMOVE_ITEM libtiff_files "${FREEIMAGE_DIR}/Source/LibTIFF/tif_acorn.c")
LIST(REMOVE_ITEM libtiff_files "${FREEIMAGE_DIR}/Source/LibTIFF/mkg3states.c")
LIST(REMOVE_ITEM libtiff_files "${FREEIMAGE_DIR}/Source/LibTIFF/tif_apple.c")
LIST(REMOVE_ITEM libtiff_files "${FREEIMAGE_DIR}/Source/LibTIFF/tif_atari.c")
LIST(REMOVE_ITEM libtiff_files "${FREEIMAGE_DIR}/Source/LibTIFF/tif_vms.c")
LIST(REMOVE_ITEM libtiff_files "${FREEIMAGE_DIR}/Source/LibTIFF/tif_win3.c")
LIST(REMOVE_ITEM libtiff_files "${FREEIMAGE_DIR}/Source/LibTIFF/tif_wince.c")


ADD_LIBRARY (FreeImage SHARED ${png_files} ${zlib_files} ${deprecation_files} 
			${freeimage_files} ${freeimagelib_files} ${libjpeg_files}
			${libmng_files} ${libopenjpeg_files} ${libraw_files}
			${libtiff_files} ${metadata_files} ${openexr_files}
			)

#INSTALL(FILES ${FREEIMAGE_DIR}/gl2ps.h DESTINATION ${INSTALL_DIR}/include/gl2ps)

INSTALL(TARGETS FreeImage
		ARCHIVE DESTINATION "${INSTALL_DIR}/lib/"
		LIBRARY DESTINATION "${INSTALL_DIR}/lib/"
		RUNTIME DESTINATION "${INSTALL_DIR}/bin/"  
		)