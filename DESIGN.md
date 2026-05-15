Design Spec: Classical macOS UI Component Set (QML)

## 1. Architectural Objective

You are tasked with building a custom desktop-first component set in QML. The aesthetic target is the **Late-Classical macOS Desktop Era (circa OS X Yosemite to macOS Catalina)**.

**Core Philosophy:**

* **Tangible but Refined:** Avoid stark, flat, ultra-minimalist modern designs (e.g., Big Sur/iOS flat controls), but do not use heavily textured skeuomorphism (early Aqua glass/gloss). Controls must look undeniably clickable and distinct from the background.
* **Lighting & Depth:** Components rely on subtle vertical linear gradients, distinct 1px outlines, crisp inner highlights, and drop shadows to establish physical depth.
* **Cross-Platform & Theme-Ready:** Must render identically on macOS and Linux, fully supporting dynamic switching between Light and Dark modes.

---

## 2. Global Design Tokens & Color Palette

Implement a centralized reactive `Theme.qml` singleton to manage these states. Never hardcode colors directly into component files.

### Base Colors

* **Primary Accent (Aqua Blue):**
* Light Mode: `#007AFF`
* Dark Mode: `#0A84FF` (Slightly more vibrant for dark contrast)


* **Window Background:**
* Light Mode: `#ECECEC`
* Dark Mode: `#1E1E1E`


* **Content Background (Text areas, lists):**
* Light Mode: `#FFFFFF`
* Dark Mode: `#252525`


* **Primary Text:**
* Light Mode: `#222222`
* Dark Mode: `#DEDEDE`


* **Disabled State:**
* Opacity: `0.4` applied to the entire control container.



---

## 3. Geometry & Spatial System

Unlike modern UI which uses massive touch-friendly padding and pill-shaped radii, classical desktop UI is compact and precise.

* **Corner Radius:** * Standard buttons, text fields, and dropdowns: **4px** (strict).
* Segmented controls and smaller tags: **3px**.
* Windows and large panels: **8px** to **10px**.


* **Borders:** Controls must always have a **1px solid border** to define their perimeter against the window background.
* **Focus Rings:** When focused, controls receive a **3px outline** using the Primary Accent color with a `0.4` opacity.

---

## 4. Lighting, Shading, and Depth Rules

To achieve the "Yosemite–Catalina" depth without heavy assets, construct controls using layered QML primitives combined with `LinearGradient` and shadow effects.

### A. Neutral Buttons & Push Controls

Buttons are not flat rectangles. They simulate a slightly curved physical surface.

* **Light Mode:**
* Fill: Vertical `LinearGradient` from `#FFFFFF` (top) to `#E6E6E6` (bottom).
* Border: `1px` solid `#C4C4C4`.
* Highlight: An inner top highlight (e.g., a 1px line at the top inner edge with `#FFFFFF` at `0.8` opacity).
* Shadow: A very subtle `DropShadow` (Y-offset: 1px, Radius: 0px, Color: `#000000` at `0.05` opacity).


* **Dark Mode:**
* Fill: Vertical `LinearGradient` from `#5C5C5C` (top) to `#454545` (bottom).
* Border: `1px` solid `#2A2A2A`.
* Highlight: Inner top edge `#7A7A7A` at `0.3` opacity.
* Shadow: Y-offset: 1px, Radius: 1px, Color: `#000000` at `0.3` opacity.



### B. Primary/Accent Buttons

* **Light Mode:** Gradient from `#34A1FF` to `#007AFF`. Border: `#0058B0`. Text: White with a subtle dark drop shadow (Y: -1, Opacity: 0.2) to make it inset.
* **Dark Mode:** Gradient from `#3AB2FF` to `#0A84FF`. Border: `#004080`.

### C. Input Fields (TextFields, TextAreas)

Inputs must look physically "sunken" into the layout.

* **Background:** Content Background color.
* **Border:** * Light Mode: `#B0B0B0` (top border slightly darker, e.g., `#999999` to simulate an overhead light casting a shadow inside the well).
* Dark Mode: `#121212` border against the `#252525` fill.


* **Inner Shadow:** Apply a subtle inner top shadow (1px Y-offset) inside the text field to reinforce the sunken aesthetic.

---

## 5. Component Implementation Directives for QML

### Base Control Architecture

* Base your components on `QtQuick.Controls.Basic` templates (e.g., `Button`, `TextField`) by overriding their `background` and `contentItem` properties. Do not build them entirely from scratch unless necessary, to preserve accessibility and focus logic.
* **Gradients:** Use `LinearGradient` from `QtGraphicalEffects` (Qt 5) or `Qt5Compat.GraphicalEffects` / `QtQuick.Studio.Effects` (Qt 6).
* **Typography:** Set system fonts dynamically. On macOS, map to `.AppleSystemUIFont` or `font.pointSize: 13`. On Linux, fallback gracefully to `Inter`, `Roboto`, or standard sans-serif at `10pt`/`11pt` to maintain visually equivalent scaling.

### State Transitions

* **Pressed State:** Invert or flatten the gradient slightly. For standard buttons, change the background fill to a solid, slightly darker shade (Light mode: `#D9D9D9`, Dark mode: `#3A3A3A`) and remove the top inner highlight.
* **Hover State:** Classical macOS does *not* heavily utilize hover background changes for standard buttons. Keep hover states extremely subtle or rely solely on the cursor change, reserving visual shifts for the `pressed` and `activeFocus` properties.

### Example QML Structure pattern for Agent Reference:

```qml
// KaakaoButton.qml
import QtQuick
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects // Assuming Qt6

KaakaoButton {
    id: control
    implicitWidth: Math.max(80, contentItem.implicitWidth + 24)
    implicitHeight: 22 // Classic compact macOS height

    background: Item {
        Rectangle {
            id: bgRect
            anchors.fill: parent
            radius: 4
            border.color: Theme.isDarkMode ? "#2A2A2A" : "#C4C4C4"
            border.width: 1
            
            // Gradient base
            LinearGradient {
                anchors.fill: parent
                anchors.margins: 1
                source: parent
                start: Qt.point(0, 0)
                end: Qt.point(0, height)
                gradient: Gradient {
                    GradientStop { 
                        position: 0.0; 
                        color: control.pressed ? Theme.buttonPressed : Theme.buttonGradTop 
                    }
                    GradientStop { 
                        position: 1.0; 
                        color: control.pressed ? Theme.buttonPressed : Theme.buttonGradBottom 
                    }
                }
                radius: 3
            }
        }
        // Focus Ring Overlay
        Rectangle {
            anchors.fill: parent
            anchors.margins: -3
            radius: 7
            border.color: Theme.primaryAccent
            border.width: 3
            opacity: control.activeFocus ? 0.4 : 0.0
            color: "transparent"
            Behavior on opacity { NumberAnimation { duration: 80 } }
        }
    }

    contentItem: Text {
        text: control.text
        font.pixelSize: 13
        font.family: DefaultFont.family // Managed by theme
        color: Theme.primaryText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}

```

