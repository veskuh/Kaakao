qt_add_executable(ComponentGallery
    main.cpp
)

target_link_libraries(ComponentGallery PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickControls2
    Qt6::Core5Compat
    Kaakao
)

# Use the Kaakao module
qt_add_qml_module(ComponentGallery
    URI Gallery
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES Main.qml
)
