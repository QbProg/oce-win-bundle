message( "External project - VTK" )

include(ExternalProject) # ExternalProject_Add

ExternalProject_Add(VTK
  DEPENDS 
  URL http://www.vtk.org/files/release/6.2/VTK-6.2.0.zip
  SOURCE_DIR ../Libs/VTK
  BINARY_DIR VTK-build
  UPDATE_COMMAND ""
  PATCH_COMMAND ""
  CMAKE_GENERATOR ${EP_CMAKE_GENERATOR}
  CMAKE_ARGS
    ${ep_common_args}
    ${_vtkOptions}
    -DBUILD_EXAMPLES:BOOL=OFF
    -DBUILD_SHARED_LIBS:BOOL=ON
    -DBUILD_TESTING:BOOL=OFF
    -DCMAKE_BUILD_TYPE:STRING=${BUILD_TYPE}
    -DVTK_BUILD_ALL_MODULES:BOOL=OFF
    -DCMAKE_INSTALL_PREFIX:PATH=${INSTALL_DEPENDENCIES_DIR}
)

set( VTK_DIR ${INSTALL_DEPENDENCIES_DIR}/lib/cmake/vtk-6.2/ )
