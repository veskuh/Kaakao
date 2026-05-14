cmake_minimum_required(VERSION 3.16)

project(Kaakao VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick QuickControls2 Core5Compat Test QuickTest)

if(POLICY QTP0001)
    qt_policy(SET QTP0001 NEW)
endif()

enable_testing()

# Always add the component module
add_subdirectory(src)

# Only add the gallery and tests if this is the top-level project
if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    add_subdirectory(gallery)
    add_subdirectory(tests)
endif()

# Documentation target
set(QDOC_EXECUTABLE "/Users/vesku/Qt/6.8.0/macos/bin/qdoc")
set(QHELPGEN_EXECUTABLE "/Users/vesku/Qt/6.8.0/macos/libexec/qhelpgenerator")

if(EXISTS ${QDOC_EXECUTABLE} AND EXISTS ${QHELPGEN_EXECUTABLE})
    add_custom_target(docs
        COMMAND ${CMAKE_COMMAND} -E rm -rf ${CMAKE_CURRENT_SOURCE_DIR}/docs/html
        COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_CURRENT_SOURCE_DIR}/docs/html
        COMMAND ${QDOC_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/docs/kaakao.qdocconf
        COMMAND ${QHELPGEN_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/docs/html/kaakao.qhp -o ${CMAKE_CURRENT_SOURCE_DIR}/docs/kaakao.qch
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/docs
        COMMENT "Generating Kaakao QDoc documentation"
    )
else()
    message(STATUS "qdoc or qhelpgenerator not found at specified paths. 'docs' target will not be available.")
endif()
