# Create a library for the gallery components so they can be tested
qt_add_library(GalleryLib SHARED)

qt_add_qml_module(GalleryLib
    URI Gallery
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES 
        AboutWindow.qml
)

qt_add_executable(KaakaoGallery
    main.cpp
)

qt_add_qml_module(KaakaoGallery
    URI GalleryApp
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        Main.qml
)

target_link_libraries(KaakaoGallery PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickControls2
    Qt6::Core5Compat
    Kaakao
    GalleryLib
)
