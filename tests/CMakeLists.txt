# Copy QML files to build directory for execution
file(COPY tst_theme.qml tst_button.qml tst_window.qml tst_label.qml tst_dialog.qml tst_about.qml tst_textfield.qml tst_controls.qml DESTINATION "${CMAKE_CURRENT_BINARY_DIR}")

# Theme Test
qt_add_executable(tst_theme main.cpp)
target_link_libraries(tst_theme PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao)
target_compile_definitions(tst_theme PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_theme COMMAND tst_theme -input tst_theme.qml)
set_tests_properties(tst_theme PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/src")

# Button Test
qt_add_executable(tst_button main.cpp)
target_link_libraries(tst_button PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao)
target_compile_definitions(tst_button PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_button COMMAND tst_button -input tst_button.qml)
set_tests_properties(tst_button PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/src")

# Window Test
qt_add_executable(tst_window main.cpp)
target_link_libraries(tst_window PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao)
target_compile_definitions(tst_window PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_window COMMAND tst_window -input tst_window.qml)
set_tests_properties(tst_window PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/src")

# Label Test
qt_add_executable(tst_label main.cpp)
target_link_libraries(tst_label PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao)
target_compile_definitions(tst_label PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_label COMMAND tst_label -input tst_label.qml)
set_tests_properties(tst_label PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/src")

# Dialog Test
qt_add_executable(tst_dialog main.cpp)
target_link_libraries(tst_dialog PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao)
target_compile_definitions(tst_dialog PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_dialog COMMAND tst_dialog -input tst_dialog.qml)
set_tests_properties(tst_dialog PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/src")

# About Window Test
qt_add_executable(tst_about main.cpp)
target_link_libraries(tst_about PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao GalleryLib)
target_compile_definitions(tst_about PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_about COMMAND tst_about -input tst_about.qml)
set_tests_properties(tst_about PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/src:${CMAKE_BINARY_DIR}/gallery")

# TextField Test
qt_add_executable(tst_textfield main.cpp)
target_link_libraries(tst_textfield PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao)
target_compile_definitions(tst_textfield PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_textfield COMMAND tst_textfield -input tst_textfield.qml)
set_tests_properties(tst_textfield PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/src")

# Controls Test
qt_add_executable(tst_controls main.cpp)
target_link_libraries(tst_controls PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao)
target_compile_definitions(tst_controls PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_controls COMMAND tst_controls -input tst_controls.qml)
set_tests_properties(tst_controls PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/src")

