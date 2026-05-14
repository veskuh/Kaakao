# Copy QML files to build directory for execution
file(COPY tst_theme.qml tst_button.qml DESTINATION "${CMAKE_CURRENT_BINARY_DIR}")

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
