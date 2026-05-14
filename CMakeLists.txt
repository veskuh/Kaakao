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
