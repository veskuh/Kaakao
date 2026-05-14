# Kaakao Project: Agent Guidelines

This document provides instructions and context for AI agents working on the **Kaakao** QML component set.

## Project Philosophy
Kaakao is a desktop-first component library targeting the **Late-Classical macOS Desktop Era** (OS X Yosemite to macOS Catalina). It balances physical tangibility with refined, non-skeuomorphic depth.

## Architectural Constraints
- **Pure QML**: Avoid C++ logic in `src/`. Use `QtQuick.Controls.Basic` as the base for all components to ensure standard desktop behavior (focus, accessibility).
- **Modern Qt 6**: Use `qt_add_qml_module`. For effects like gradients and shadows, use `Qt5Compat.GraphicalEffects`.
- **Submodule Support**: Maintain the conditional `gallery/` and `tests/` build in the root `CMakeLists.txt`.

## Design System (Strict Adherence Required)
- **Theme Singleton**: All components MUST use the centralized reactive `Theme` singleton (`Theme.qml`). It supports dynamic **Light/Dark mode** switching via `Qt.styleHints.colorScheme`.
- **Aesthetic**:
    - **Corner Radius**: 4px (Standard), 3px (Small/Segmented), 8-10px (Windows/Panels).
    - **Borders**: Always 1px solid border to define depth.
    - **Gradients**: Use subtle vertical linear gradients (Top-to-Bottom) for buttons and surfaces.
    - **Focus Rings**: 3px outline using Primary Accent color at 0.4 opacity.
- **Palette**:
    - **Primary Accent**: Light `#007AFF`, Dark `#0A84FF`.
    - **Window Background**: Light `#ECECEC`, Dark `#1E1E1E`.
    - **Content Background**: Light `#FFFFFF`, Dark `#252525`.

## Component Implementation Rules
- **Layering**: Build depth using layered QML primitives (Rectangles, Gradients, Inner Highlights).
- **Sunken Inputs**: `TextField` and `TextArea` must look "sunken" with subtle inner top shadows.
- **Typography**: Target 13px (MacOS `.AppleSystemUIFont`) or visually equivalent 10pt/11pt sans-serif on other platforms via `Theme.defaultFont`.

## Testing Strategy (Mandatory)
- **Headless Tests**: Tests in `tests/` MUST run headlessly. Use static component instantiation inside `TestCase` to avoid window activation issues (`visible: false`).
- **Property Verification**: Focus on verifying properties, theme linkage, and state transitions (e.g., using the `down` property for buttons) rather than mouse interaction.
- **Automated Verification**: Every new component MUST have a corresponding `tst_<name>.qml` test case.

## Workflow
1. **Implementation**: Create/update the component in `src/`. Use `Theme` tokens strictly.
2. **Gallery**: Add a demonstration of the component to `gallery/Main.qml`.
3. **Tests**: Create/update a test in `tests/` using the headless static pattern.
4. **Build & Verify**: Ensure `ComponentGallery` runs and `ctest --output-on-failure` passes.
5. **Singleton Registration**: Register singletons in `src/CMakeLists.txt` using `set_source_files_properties(... PROPERTIES QT_QML_SINGLETON_TYPE TRUE)` *before* the `qt_add_qml_module` call.
