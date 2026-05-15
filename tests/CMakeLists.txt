# Copy QML files to build directory for execution
file(COPY tst_theme.qml tst_kaakaobutton.qml tst_window.qml tst_label.qml tst_dialog.qml tst_about.qml tst_textfield.qml tst_controls.qml tst_toolbar.qml tst_sidebar.qml tst_indicators.qml tst_searchfield.qml tst_disclosure.qml tst_listview.qml tst_tableview.qml DESTINATION "${CMAKE_CURRENT_BINARY_DIR}")

# Theme Test
qt_add_executable(tst_theme main.cpp)
target_link_libraries(tst_theme PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao)
target_compile_definitions(tst_theme PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_theme COMMAND tst_theme -input tst_theme.qml)
set_tests_properties(tst_theme PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/qml")

# Button Test
qt_add_executable(tst_kaakaobutton main.cpp)
target_link_libraries(tst_kaakaobutton PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao)
target_compile_definitions(tst_kaakaobutton PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_kaakaobutton COMMAND tst_kaakaobutton -input tst_kaakaobutton.qml)
set_tests_properties(tst_kaakaobutton PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/qml")

# Window Test
qt_add_executable(tst_window main.cpp)
target_link_libraries(tst_window PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao)
target_compile_definitions(tst_window PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_window COMMAND tst_window -input tst_window.qml)
set_tests_properties(tst_window PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/qml")

# Label Test
qt_add_executable(tst_label main.cpp)
target_link_libraries(tst_label PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao)
target_compile_definitions(tst_label PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_label COMMAND tst_label -input tst_label.qml)
set_tests_properties(tst_label PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/qml")

# Dialog Test
qt_add_executable(tst_dialog main.cpp)
target_link_libraries(tst_dialog PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao)
target_compile_definitions(tst_dialog PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_dialog COMMAND tst_dialog -input tst_dialog.qml)
set_tests_properties(tst_dialog PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/qml")

# About Window Test
qt_add_executable(tst_about main.cpp)
target_link_libraries(tst_about PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao GalleryLib)
target_compile_definitions(tst_about PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_about COMMAND tst_about -input tst_about.qml)
set_tests_properties(tst_about PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/qml")

# TextField Test
qt_add_executable(tst_textfield main.cpp)
target_link_libraries(tst_textfield PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao)
target_compile_definitions(tst_textfield PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_textfield COMMAND tst_textfield -input tst_textfield.qml)
set_tests_properties(tst_textfield PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/qml")

# Controls Test
qt_add_executable(tst_controls main.cpp)
target_link_libraries(tst_controls PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao)
target_compile_definitions(tst_controls PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_controls COMMAND tst_controls -input tst_controls.qml)
set_tests_properties(tst_controls PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/qml")

# ToolBar Test
qt_add_executable(tst_toolbar main.cpp)
target_link_libraries(tst_toolbar PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao)
target_compile_definitions(tst_toolbar PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_toolbar COMMAND tst_toolbar -input tst_toolbar.qml)
set_tests_properties(tst_toolbar PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/qml")


# Sidebar Test
qt_add_executable(tst_sidebar main.cpp)
target_link_libraries(tst_sidebar PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao)
target_compile_definitions(tst_sidebar PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_sidebar COMMAND tst_sidebar -input tst_sidebar.qml)
set_tests_properties(tst_sidebar PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/qml")

# Indicator Test
qt_add_executable(tst_indicators main.cpp)
target_link_libraries(tst_indicators PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao)
target_compile_definitions(tst_indicators PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_indicators COMMAND tst_indicators -input tst_indicators.qml)
set_tests_properties(tst_indicators PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/qml")

# SearchField Test
qt_add_executable(tst_searchfield main.cpp)
target_link_libraries(tst_searchfield PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao)
target_compile_definitions(tst_searchfield PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_searchfield COMMAND tst_searchfield -input tst_searchfield.qml)
set_tests_properties(tst_searchfield PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/qml")

# Disclosure Test
qt_add_executable(tst_disclosure main.cpp)
target_link_libraries(tst_disclosure PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao)
target_compile_definitions(tst_disclosure PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_disclosure COMMAND tst_disclosure -input tst_disclosure.qml)
set_tests_properties(tst_disclosure PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/qml")

# ListView Test
qt_add_executable(tst_listview main.cpp)
target_link_libraries(tst_listview PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao)
target_compile_definitions(tst_listview PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_listview COMMAND tst_listview -input tst_listview.qml)
set_tests_properties(tst_listview PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/qml")

# TableView Test
qt_add_executable(tst_tableview main.cpp)
target_link_libraries(tst_tableview PRIVATE Qt6::Core Qt6::Gui Qt6::Qml Qt6::Quick Qt6::Test Qt6::QuickTest Kaakao)
target_compile_definitions(tst_tableview PRIVATE QUICK_TEST_SOURCE_DIR="${CMAKE_CURRENT_BINARY_DIR}")
add_test(NAME tst_tableview COMMAND tst_tableview -input tst_tableview.qml)
set_tests_properties(tst_tableview PROPERTIES ENVIRONMENT "QML_IMPORT_PATH=${CMAKE_BINARY_DIR}/qml")
