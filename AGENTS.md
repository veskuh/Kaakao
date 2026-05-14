# Kaakao Project: Agent Guidelines

This document provides instructions and context for AI agents working on the **Kaakao** QML component set.

## Project Philosophy
Kaakao is a desktop-first component library targeting the **Late-Classical macOS Desktop Era** (OS X Yosemite to macOS Catalina). It balances physical tangibility with refined, non-skeuomorphic depth.

## Architectural Constraints
- **Module Separation**: 
    - `src/`: Contains the `Kaakao` module. Strictly for reusable library primitives (e.g., `Button`, `KaakaoLabel`, `KaakaoDialog`). **No application-specific logic allowed here.**
    - `gallery/`: Contains the `Gallery` (library) and `GalleryApp` (executable) modules. For demonstrator-specific views (e.g., `AboutWindow`).
- **Pure QML**: Avoid C++ logic in `src/`. Use `QtQuick.Controls.Basic` as the base for all components.
- **Modern Qt 6**: Use `qt_add_qml_module`. For effects, use `Qt5Compat.GraphicalEffects`.
- **Submodule Support**: Maintain conditional builds in the root `CMakeLists.txt` so `gallery/` and `tests/` are skipped when Kaakao is used as a submodule.

## Design System (Strict Adherence Required)
- **Theme Singleton**: All components MUST use the centralized reactive `Theme` singleton (`Theme.qml`).
- **Aesthetic**:
    - **Corner Radius**: 4px (Standard), 3px (Small/Segmented), 8-10px (Windows/Panels/Dialogs).
    - **Borders**: Always 1px solid border to define depth.
    - **Gradients**: Use subtle vertical linear gradients (Top-to-Bottom) for buttons and surfaces.
    - **Focus Rings**: Use `KaakaoFocusRing` for consistent 3px outlines using Primary Accent color at 0.4 opacity.
- **Palette**:
    - **Primary Accent**: Light `#007AFF`, Dark `#0A84FF`.
    - **Window Background**: Light `#ECECEC`, Dark `#1E1E1E`.
    - **Content Background**: Light `#FFFFFF`, Dark `#252525`.

## Component Implementation Rules
- **Layering**: Build depth using layered QML primitives (Rectangles, Gradients, Inner Highlights).
- **Sunken Inputs**: `TextField` and `TextArea` must look "sunken" with subtle inner top shadows.
- **Typography**: Use `Theme.defaultFont` (13px standard).

## Testing Strategy (Mandatory)
- **Headless Tests**: Tests in `tests/` MUST run headlessly (`visible: false`) using static component instantiation.
- **Verification**: Every new component MUST have a corresponding `tst_<name>.qml` test case.
- **Linking**: If testing app-specific views in `gallery/`, link the test against `GalleryLib`.

## Workflow
1. **Implementation**: Create reusable primitives in `src/` or app-specific views in `gallery/`.
2. **Gallery**: Demonstrate components in `gallery/Main.qml`. Import `Gallery` if using app-specific views.
3. **Tests**: Create a test in `tests/` using the headless static pattern.
4. **Build & Verify**: Ensure `ComponentGallery` runs and `ctest --output-on-failure` passes.
5. **Singleton Registration**: Register singletons in `src/CMakeLists.txt` using `set_source_files_properties(... PROPERTIES QT_QML_SINGLETON_TYPE TRUE)` *before* the `qt_add_qml_module` call.
 primitives in `src/` or app-specific views in `gallery/`.
2. **Gallery**: Demonstrate components in `gallery/Main.qml`. Import `Gallery` if using app-specific views.
3. **Tests**: Create a test in `tests/` using the headless static pattern.
4. **Build & Verify**: Ensure `ComponentGallery` runs and `ctest --output-on-failure` passes.
5. **Singleton Registration**: Register singletons in `src/CMakeLists.txt` using `set_source_files_properties(... PROPERTIES QT_QML_SINGLETON_TYPE TRUE)` *before* the `qt_add_qml_module` call.
