message("Setting oce-win-bundle depends...")

# Add dependencies between OCE and oce-win-bundle
if(OCE_WITH_FREEIMAGE)
    add_dependencies( TKService FreeImage )
endif()

if (OCE_VISUALISATION)
    add_dependencies( TKOpenGl freetype gl2ps )
endif()

