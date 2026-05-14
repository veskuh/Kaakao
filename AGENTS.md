# Kaakao Project: Agent Guidelines

This document provides instructions and context for AI agents working on the **Kaakao** QML component set.

## Project Philosophy
Kaakao is a desktop-first component library targeting the **Late-Classical macOS Desktop Era** (OS X Yosemite to macOS Catalina). It balances physical tangibility with refined, non-skeuomorphic depth.

## Architectural Constraints
- **Pure QML**: Avoid C++ logic in `src/`. Use `QtQuick.Controls.Basic` as the base for all components to ensure standard desktop behavior (focus, accessibility).
- **Modern Qt 6**: Use `qt_add_qml_module`. For effects like gradients and shadows, use `Qt5Compat.GraphicalEffects` (ensure it is available) or modern Qt Quick MultiEffect where appropriate.
- **Submodule Support**: Maintain the conditional `gallery/` build in the root `CMakeLists.txt`.

## Design System (Strict Adherence Required)
- **Theme Singleton**: All components MUST use a centralized reactive `Theme.qml` (or `Theme` singleton). It must support dynamic **Light/Dark mode** switching.
- **Aesthetic**:
    - **Corner Radius**: 4px (Standard), 8-10px (Windows/Panels).
    - **Borders**: Always 1px solid border to define depth.
    - **Gradients**: Use subtle vertical linear gradients (Top-to-Bottom) for buttons and surfaces.
    - **Focus Rings**: 3px outline using Primary Accent color at 0.4 opacity when `activeFocus` is true.
- **Palette**:
    - **Primary Accent**: Light `#007AFF`, Dark `#0A84FF`.
    - **Window Background**: Light `#ECECEC`, Dark `#1E1E1E`.
    - **Content Background**: Light `#FFFFFF`, Dark `#252525`.

## Component Implementation Rules
- **Layering**: Build depth using layered QML primitives (Rectangles, Gradients, Inner Highlights).
- **Sunken Inputs**: `TextField` and `TextArea` must look "sunken" with subtle inner top shadows.
- **Typography**: Target 13px (MacOS `.AppleSystemUIFont`) or visually equivalent 10pt/11pt sans-serif on other platforms.

## Workflow
- **Verification**: Demonstrate new components in `gallery/Main.qml`.
- **Build**: Ensure the `ComponentGallery` target builds and runs.
- **Singleton Registration**: Register singletons (like `Theme.qml`) using `set_source_files_properties(... PROPERTIES QT_QML_SINGLETON_TYPE TRUE)` *before* the `qt_add_qml_module` call.
