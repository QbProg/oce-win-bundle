####### FREEIMAGE
PROJECT(FreeImage)
ADD_DEFINITIONS("-D_CRT_SECURE_NO_DEPRECATE")
ADD_DEFINITIONS("-D_CRT_NONSTDC_NO_WARNINGS")
ADD_DEFINITIONS("-DFREEIMAGE_EXPORTS")
#ADD_DEFINITIONS("-DHAVE_STDLIB_H")
ADD_DEFINITIONS("-DOPJ_STATIC")
ADD_DEFINITIONS("-DUSE_JPIP")
ADD_DEFINITIONS("-DLIBRAW_BUILDLIB")
ADD_DEFINITIONS("-DLIBRAW_NODLL")
ADD_DEFINITIONS("-DMNG_BUILD_SO")
ADD_DEFINITIONS("-DFIP_EXPORTS")
ADD_DEFINITIONS("-DNO_JASPER")
ADD_DEFINITIONS("-DLIBRAW_NOTHREADS")

IF(CMAKE_COMPILER_IS_GNUCXX)
  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fpermissive")
  LINK_LIBRARIES(Ws2_32)
ENDIF()

INCLUDE_DIRECTORIES(${LIBPNG_DIR})
INCLUDE_DIRECTORIES(${ZLIB_DIR})
INCLUDE_DIRECTORIES(${FREEIMAGE_DIR}/Source/)
INCLUDE_DIRECTORIES(${FREEIMAGE_DIR}/Source/librawlite)
INCLUDE_DIRECTORIES(${FREEIMAGE_DIR}/Source/OpenEXR/Imath)
INCLUDE_DIRECTORIES(${FREEIMAGE_DIR}/Source/OpenEXR/IlmImf)
INCLUDE_DIRECTORIES(${FREEIMAGE_DIR}/Source/OpenEXR/Iex)
INCLUDE_DIRECTORIES(${FREEIMAGE_DIR}/Source/OpenEXR/IexMath)
INCLUDE_DIRECTORIES(${FREEIMAGE_DIR}/Source/OpenEXR/half)
INCLUDE_DIRECTORIES(${FREEIMAGE_DIR}/Source/OpenEXR/IlmThread)
INCLUDE_DIRECTORIES(${FREEIMAGE_DIR}/Source/OpenEXR/)
INCLUDE_DIRECTORIES(${FREEIMAGE_DIR}/Source/LibJXR/jxrgluelib)
INCLUDE_DIRECTORIES(${FREEIMAGE_DIR}/Source/LibJXR/common/include)
INCLUDE_DIRECTORIES(${FREEIMAGE_DIR}/Source/LibJXR/image/sys)
INCLUDE_DIRECTORIES(${FREEIMAGE_DIR}/Source/LibJPEG)
INCLUDE_DIRECTORIES(${FREEIMAGE_DIR}/Wrapper/FreeImagePlus/)

FILE(GLOB png_files ${LIBPNG_DIR}/*.c)
FILE(GLOB zlib_files ${ZLIB_DIR}/*.c)
FILE(GLOB deprecation_files ${FREEIMAGE_DIR}/Source/DeprecationManager/*.cpp)
FILE(GLOB_RECURSE freeimage_files ${FREEIMAGE_DIR}/Source/FreeImage/*.cpp )
FILE(GLOB_RECURSE freeimage_plus_files ${FREEIMAGE_DIR}/Wrapper/FreeImagePlus/src/*.cpp )
FILE(GLOB_RECURSE freeimage_c_files ${FREEIMAGE_DIR}/Source/FreeImage/*.c )
FILE(GLOB freeimagetoolkit_files ${FREEIMAGE_DIR}/Source/FreeImageToolkit/*.cpp )
FILE(GLOB libjpeg_files ${FREEIMAGE_DIR}/Source/LibJPEG/j*.c ${FREEIMAGE_DIR}/Source/LibJPEG/transupp.c)
FILE(GLOB libmng_files ${FREEIMAGE_DIR}/Source/LibMNG/*.c)
FILE(GLOB libopenjpeg_files ${FREEIMAGE_DIR}/Source/LibOpenJPEG/*.c)
FILE(GLOB_RECURSE libraw_files ${FREEIMAGE_DIR}/Source/LibRawLite/src/*.cpp)
LIST(APPEND libraw_files ${FREEIMAGE_DIR}/Source/LibRawLite/internal/demosaic_packs.cpp ${FREEIMAGE_DIR}/Source/LibRawLite/internal/dcraw_common.cpp ${FREEIMAGE_DIR}/Source/LibRawLite/internal/dcraw_fileio.cpp)
FILE(GLOB libtiff_files ${FREEIMAGE_DIR}/Source/LibTIFF4/*.c)
FILE(GLOB metadata_files ${FREEIMAGE_DIR}/Source/metadata/*.cpp)
FILE(GLOB_RECURSE openexr_files ${FREEIMAGE_DIR}/Source/OpenEXR/*.cpp)
FILE(GLOB_RECURSE jxr_files ${FREEIMAGE_DIR}/Source/LibJXR/*.c)
FILE(GLOB_RECURSE webp_files ${FREEIMAGE_DIR}/Source/LibWebP/*.c)

LIST(REMOVE_ITEM zlib_files "${ZLIB_DIR}/example.c")
LIST(REMOVE_ITEM zlib_files "${ZLIB_DIR}/minigzip.c")
LIST(REMOVE_ITEM png_files "${LIBPNG_DIR}/pngtest.c")

LIST(REMOVE_ITEM libjpeg_files "${FREEIMAGE_DIR}/Source/LibJPEG/jpegtran.c")
LIST(REMOVE_ITEM libjpeg_files "${FREEIMAGE_DIR}/Source/LibJPEG/jmemdos.c")
LIST(REMOVE_ITEM libjpeg_files "${FREEIMAGE_DIR}/Source/LibJPEG/jmemmac.c")
LIST(REMOVE_ITEM libjpeg_files "${FREEIMAGE_DIR}/Source/LibJPEG/jmemansi.c")
LIST(REMOVE_ITEM libjpeg_files "${FREEIMAGE_DIR}/Source/LibJPEG/jmemnobs.c")
LIST(REMOVE_ITEM libjpeg_files "${FREEIMAGE_DIR}/Source/LibJPEG/example.c")
LIST(REMOVE_ITEM libopenjpeg_files "${FREEIMAGE_DIR}/Source/LibOpenJPEG/t1_generate_luts.c")
LIST(REMOVE_ITEM libtiff_files "${FREEIMAGE_DIR}/Source/LibTIFF4/tif_unix.c")
LIST(REMOVE_ITEM libtiff_files "${FREEIMAGE_DIR}/Source/LibTIFF4/tif_acorn.c")
LIST(REMOVE_ITEM libtiff_files "${FREEIMAGE_DIR}/Source/LibTIFF4/mkg3states.c")
LIST(REMOVE_ITEM libtiff_files "${FREEIMAGE_DIR}/Source/LibTIFF4/tif_apple.c")
LIST(REMOVE_ITEM libtiff_files "${FREEIMAGE_DIR}/Source/LibTIFF4/tif_atari.c")
LIST(REMOVE_ITEM libtiff_files "${FREEIMAGE_DIR}/Source/LibTIFF4/tif_vms.c")
LIST(REMOVE_ITEM libtiff_files "${FREEIMAGE_DIR}/Source/LibTIFF4/tif_win3.c")
LIST(REMOVE_ITEM libtiff_files "${FREEIMAGE_DIR}/Source/LibTIFF4/tif_wince.c")
LIST(REMOVE_ITEM libtiff_files "${FREEIMAGE_DIR}/Source/LibTIFF4/tif_win32.c")
LIST(REMOVE_ITEM libtiff_files "${FREEIMAGE_DIR}/Source/LibTIFF4/tif_msdos.c")
LIST(REMOVE_ITEM libtiff_files "${FREEIMAGE_DIR}/Source/LibTIFF4/mkspans.c")
LIST(REMOVE_ITEM openexr_files "${FREEIMAGE_DIR}/Source/OpenEXR/IlmThread/IlmThreadMutexWin32.cpp")
LIST(REMOVE_ITEM openexr_files "${FREEIMAGE_DIR}/Source/OpenEXR/IlmThread/IlmThreadWin32.cpp")
LIST(REMOVE_ITEM openexr_files "${FREEIMAGE_DIR}/Source/OpenEXR/IlmThread/IlmThreadSemaphoreWin32.cpp")
LIST(REMOVE_ITEM openexr_files "${FREEIMAGE_DIR}/Source/OpenEXR/Half/eLut.cpp")
LIST(REMOVE_ITEM openexr_files "${FREEIMAGE_DIR}/Source/OpenEXR/Half/toFloat.cpp")
LIST(REMOVE_ITEM openexr_files "${FREEIMAGE_DIR}/Source/OpenEXR/IlmImf/b44ExpLogTable.cpp")



ADD_LIBRARY (FreeImage ${BUNDLE_LIB_MODIFIER} ${png_files} ${zlib_files} ${deprecation_files} 
			${freeimage_files} ${freeimage_c_files} ${freeimagetoolkit_files} ${freeimagelib_files} ${libjpeg_files}
			${libmng_files} ${libopenjpeg_files} ${libraw_files}
			${libtiff_files} ${metadata_files} ${openexr_files} ${jxr_files} ${webp_files}
			)

FILE(GLOB freeimage_headers ${FREEIMAGE_DIR}/Source/*.h)
FILE(GLOB fip_headers ${FREEIMAGE_DIR}/Wrapper/FreeImagePlus/*.h)
INSTALL(FILES ${fip_headers} ${freeimage_headers} DESTINATION ${OCE_WIN_BUNDLE_INSTALL_DIR}/include/FreeImage)

INSTALL(TARGETS FreeImage
		ARCHIVE DESTINATION  "${OCE_WIN_BUNDLE_INSTALL_DIR_BITS}/lib/" CONFIGURATIONS Debug Release MinSizeRel RelWithDebInfo
		LIBRARY DESTINATION  "${OCE_WIN_BUNDLE_INSTALL_DIR_BITS}/lib/" CONFIGURATIONS Debug Release MinSizeRel RelWithDebInfo
		RUNTIME DESTINATION  "${OCE_WIN_BUNDLE_INSTALL_DIR_BITS}/bin/" CONFIGURATIONS Debug Release MinSizeRel RelWithDebInfo
		)

# FreeImagePlus
FILE(GLOB freeimagelib_files ${FREEIMAGE_DIR}/Source/FreeImageLib/*.cpp)
LIST(REMOVE_ITEM freeimage_plus_files "${FREEIMAGE_DIR}/Wrapper/FreeImagePlus/src/FreeImagePlus.cpp")

ADD_LIBRARY (FreeImagePlus ${BUNDLE_LIB_MODIFIER} ${freeimage_plus_files})
TARGET_LINK_LIBRARIES(FreeImagePlus FreeImage)

INSTALL(TARGETS FreeImagePlus
		ARCHIVE DESTINATION  "${OCE_WIN_BUNDLE_INSTALL_DIR_BITS}/lib/" CONFIGURATIONS Debug Release MinSizeRel RelWithDebInfo
		LIBRARY DESTINATION  "${OCE_WIN_BUNDLE_INSTALL_DIR_BITS}/lib/" CONFIGURATIONS Debug Release MinSizeRel RelWithDebInfo
		RUNTIME DESTINATION  "${OCE_WIN_BUNDLE_INSTALL_DIR_BITS}/bin/" CONFIGURATIONS Debug Release MinSizeRel RelWithDebInfo
		)