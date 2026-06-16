import QtQuick
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

/*!
    \qmltype KaakaoControlButton
    \inqmlmodule Kaakao
    \brief A classical macOS-style control button (close/minimize/zoom/help/add/remove/gear/info/refresh/playback) for tabs, panels, and window controls.
    \inherits QtQuick.Controls.Button

    KaakaoControlButton supports inline styles (e.g. tab close buttons, panel controls) and
    window control styles (traffic lights: close, minimize, zoom) with precise classical macOS aesthetics. All styles are circular.
*/
Button {
    id: control

    enum ControlStyle {
        Inline = 0,
        Window = 1,
        Help = 2,
        Add = 3,
        Remove = 4,
        Gear = 5,
        Info = 6,
        Refresh = 7,
        Play = 8,
        Pause = 9,
        Next = 10,
        Previous = 11
    }

    enum ControlType {
        Close = 0,
        Minimize = 1,
        Zoom = 2
    }

    property int controlStyle: KaakaoControlButton.ControlStyle.Inline
    property int controlType: KaakaoControlButton.ControlType.Close
    
    // Whether the window or container is active.
    // When false, Window-style controls render in inactive gray.
    property bool active: true

    // When true, forces the symbols to be visible on Window-style controls
    // even if not hovered individually (typically set when the window titlebar is hovered).
    property bool groupHovered: false

    implicitWidth: {
        if (controlStyle === KaakaoControlButton.ControlStyle.Inline ||
            controlStyle === KaakaoControlButton.ControlStyle.Window) return 14
        return 16 // Help, Info, Add, Remove, Gear, Refresh, Play, Pause, Next, Previous
    }
    implicitHeight: implicitWidth

    padding: 0
    hoverEnabled: true

    background: Rectangle {
        id: bgRect
        anchors.fill: parent
        radius: width / 2
        
        color: {
            if (control.controlStyle === KaakaoControlButton.ControlStyle.Inline) {
                if (control.pressed) {
                    return Theme.isDarkMode ? "#555555" : "#D0D0D0"
                }
                if (control.hovered) {
                    return Theme.isDarkMode ? "#454545" : "#E5E5E5"
                }
                return "transparent"
            } else if (control.controlStyle === KaakaoControlButton.ControlStyle.Window) {
                if (!control.active) {
                    return Theme.isDarkMode ? "#4A4A4A" : "#E0E0E0"
                }
                
                // Color when active based on type
                switch (control.controlType) {
                    case KaakaoControlButton.ControlType.Close:
                        return control.pressed ? "#CC4C46" : "#FF5F56"
                    case KaakaoControlButton.ControlType.Minimize:
                        return control.pressed ? "#CC9725" : "#FFBD2E"
                    case KaakaoControlButton.ControlType.Zoom:
                        return control.pressed ? "#1FA032" : "#27C93F"
                }
            } else { // Help, Info, Add, Remove, Gear, Refresh, Playback
                if (control.pressed) {
                    return Theme.buttonPressed
                }
                return "transparent"
            }
            return "transparent"
        }

        border.width: control.controlStyle === KaakaoControlButton.ControlStyle.Inline ? 0 : 1
        border.color: {
            if (control.controlStyle === KaakaoControlButton.ControlStyle.Window) {
                if (!control.active) {
                    return Theme.isDarkMode ? "#3A3A3A" : "#D0D0D0"
                }
                switch (control.controlType) {
                    case KaakaoControlButton.ControlType.Close:
                        return "#E0443E"
                    case KaakaoControlButton.ControlType.Minimize:
                        return "#DEA123"
                    case KaakaoControlButton.ControlType.Zoom:
                        return "#1AAB29"
                }
            } else if (control.controlStyle === KaakaoControlButton.ControlStyle.Inline) {
                return "transparent"
            } else { // Help, Info, Add, Remove, Gear, Refresh, Playback
                return Theme.buttonBorder
            }
            return "transparent"
        }

        // Gradient base for Help, Info, Add, Remove, Gear, Refresh, Playback
        Rectangle {
            anchors.fill: parent
            anchors.margins: 1
            radius: bgRect.radius > 0 ? bgRect.radius - 1 : 0
            visible: {
                var s = control.controlStyle
                return (s === KaakaoControlButton.ControlStyle.Help ||
                        s === KaakaoControlButton.ControlStyle.Info ||
                        s === KaakaoControlButton.ControlStyle.Add ||
                        s === KaakaoControlButton.ControlStyle.Remove ||
                        s === KaakaoControlButton.ControlStyle.Gear ||
                        s === KaakaoControlButton.ControlStyle.Refresh ||
                        s === KaakaoControlButton.ControlStyle.Play ||
                        s === KaakaoControlButton.ControlStyle.Pause ||
                        s === KaakaoControlButton.ControlStyle.Next ||
                        s === KaakaoControlButton.ControlStyle.Previous) && !control.pressed
            }
            
            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: Theme.buttonGradTop
                }
                GradientStop {
                    position: 1.0
                    color: Theme.buttonGradBottom
                }
            }

            // Top-edge inner highlight for depth
            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: 1
                anchors.leftMargin: 2
                anchors.rightMargin: 2
                height: 1
                color: Theme.buttonHighlight
                radius: parent.radius > 0 ? parent.radius - 1 : 0
            }
        }
    }

    contentItem: Item {
        anchors.fill: parent
        opacity: control.enabled ? 1.0 : Theme.disabledOpacity

        // Help button content "?"
        Text {
            anchors.centerIn: parent
            visible: control.controlStyle === KaakaoControlButton.ControlStyle.Help
            text: "?"
            font.family: Theme.defaultFont.family
            font.pixelSize: Math.max(9, control.height * 0.7)
            font.bold: true
            color: Theme.primaryAccent
            renderType: Text.NativeRendering
        }

        // Info button content "i"
        Text {
            anchors.centerIn: parent
            visible: control.controlStyle === KaakaoControlButton.ControlStyle.Info
            text: "i"
            font.family: Theme.defaultFont.family
            font.pixelSize: Math.max(10, control.height * 0.7)
            font.bold: true
            color: Theme.primaryText
            renderType: Text.NativeRendering
        }

        // Refresh button content "↻"
        Text {
            anchors.centerIn: parent
            visible: control.controlStyle === KaakaoControlButton.ControlStyle.Refresh
            text: "↻"
            font.family: Theme.defaultFont.family
            font.pixelSize: Math.max(11, control.height * 0.65)
            font.bold: true
            color: Theme.primaryText
            renderType: Text.NativeRendering
        }

        // Play button content "▶"
        Text {
            anchors.centerIn: parent
            anchors.horizontalCenterOffset: 0.5 // visually center triangle
            visible: control.controlStyle === KaakaoControlButton.ControlStyle.Play
            text: "▶"
            font.family: Theme.defaultFont.family
            font.pixelSize: Math.max(8, control.height * 0.45)
            color: Theme.primaryText
            renderType: Text.NativeRendering
        }

        // Pause symbol (two vertical lines)
        Item {
            anchors.centerIn: parent
            width: Math.max(6, control.width * 0.3)
            height: Math.max(8, control.height * 0.4)
            visible: control.controlStyle === KaakaoControlButton.ControlStyle.Pause

            // Left bar
            Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: 1.5
                color: Theme.primaryText
            }
            // Right bar
            Rectangle {
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: 1.5
                color: Theme.primaryText
            }
        }

        // Next symbol (triangle + line)
        Item {
            anchors.centerIn: parent
            width: Math.max(8, control.width * 0.4)
            height: Math.max(8, control.height * 0.4)
            visible: control.controlStyle === KaakaoControlButton.ControlStyle.Next

            // Triangle
            Text {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: "▶"
                font.family: Theme.defaultFont.family
                font.pixelSize: parent.height
                color: Theme.primaryText
                renderType: Text.NativeRendering
            }

            // Vertical line
            Rectangle {
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0.5
                anchors.topMargin: 0.5
                width: 1.5
                color: Theme.primaryText
            }
        }

        // Previous symbol (line + left triangle)
        Item {
            anchors.centerIn: parent
            width: Math.max(8, control.width * 0.4)
            height: Math.max(8, control.height * 0.4)
            visible: control.controlStyle === KaakaoControlButton.ControlStyle.Previous

            // Vertical line
            Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0.5
                anchors.topMargin: 0.5
                width: 1.5
                color: Theme.primaryText
            }

            // Triangle
            Text {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: "◀"
                font.family: Theme.defaultFont.family
                font.pixelSize: parent.height
                color: Theme.primaryText
                renderType: Text.NativeRendering
            }
        }

        // Add symbol (plus sign)
        Item {
            anchors.centerIn: parent
            width: Math.max(8, control.width * 0.45)
            height: width
            visible: control.controlStyle === KaakaoControlButton.ControlStyle.Add

            // Horizontal line
            Rectangle {
                anchors.centerIn: parent
                width: parent.width
                height: 1.2
                color: Theme.primaryText
            }
            // Vertical line
            Rectangle {
                anchors.centerIn: parent
                width: 1.2
                height: parent.height
                color: Theme.primaryText
            }
        }

        // Remove symbol (minus sign)
        Rectangle {
            anchors.centerIn: parent
            width: Math.max(8, control.width * 0.45)
            height: 1.2
            visible: control.controlStyle === KaakaoControlButton.ControlStyle.Remove
            color: Theme.primaryText
        }

        // Gear symbol (Action cog)
        Item {
            id: gearContainer
            anchors.centerIn: parent
            width: Math.max(10, control.width * 0.5)
            height: width
            visible: control.controlStyle === KaakaoControlButton.ControlStyle.Gear

            // Outer teeth
            Repeater {
                model: 8
                Rectangle {
                    anchors.centerIn: parent
                    width: 2.2
                    height: gearContainer.height
                    color: Theme.primaryText
                    rotation: index * 45
                }
            }

            // Gear body (solid disk)
            Rectangle {
                anchors.centerIn: parent
                width: gearContainer.width * 0.72
                height: width
                radius: width / 2
                color: Theme.primaryText
            }

            // Gear center hole
            Rectangle {
                anchors.centerIn: parent
                width: gearContainer.width * 0.28
                height: width
                radius: width / 2
                color: {
                    if (control.pressed) return Theme.buttonPressed
                    return Theme.isDarkMode ? "#4E4E4E" : "#ECECEC" // Approximate button gradient color at center
                }
            }
        }

        // Inline close or Window close symbol (×)
        Item {
            anchors.centerIn: parent
            width: Math.max(6, control.width * 0.45)
            height: width
            visible: {
                if (control.controlStyle === KaakaoControlButton.ControlStyle.Inline) {
                    return true
                }
                if (control.controlStyle === KaakaoControlButton.ControlStyle.Window && 
                    control.controlType === KaakaoControlButton.ControlType.Close) {
                    return (control.hovered || control.groupHovered)
                }
                return false
            }

            // Draw a cross using two thin rotated lines for maximum visual sharpness
            Rectangle {
                anchors.centerIn: parent
                width: parent.width
                height: 1.2
                rotation: 45
                color: {
                    if (control.controlStyle === KaakaoControlButton.ControlStyle.Inline) {
                        if (control.hovered || control.pressed) {
                            return Theme.isDarkMode ? "#DEDEDE" : "#333333"
                        }
                        return Theme.isDarkMode ? "#8E8E8E" : "#808080"
                    }
                    return Qt.rgba(0, 0, 0, 0.55)
                }
            }

            Rectangle {
                anchors.centerIn: parent
                width: parent.width
                height: 1.2
                rotation: -45
                color: {
                    if (control.controlStyle === KaakaoControlButton.ControlStyle.Inline) {
                        if (control.hovered || control.pressed) {
                            return Theme.isDarkMode ? "#DEDEDE" : "#333333"
                        }
                        return Theme.isDarkMode ? "#8E8E8E" : "#808080"
                    }
                    return Qt.rgba(0, 0, 0, 0.55)
                }
            }
        }

        // Window Minimize symbol (horizontal line)
        Rectangle {
            anchors.centerIn: parent
            width: Math.max(6, control.width * 0.45)
            height: 1.2
            visible: {
                if (control.controlStyle === KaakaoControlButton.ControlStyle.Window && 
                    control.controlType === KaakaoControlButton.ControlType.Minimize) {
                    return (control.hovered || control.groupHovered)
                }
                return false
            }
            color: Qt.rgba(0, 0, 0, 0.55)
        }

        // Window Zoom symbol (plus sign / diagonal arrows)
        Item {
            anchors.centerIn: parent
            width: Math.max(6, control.width * 0.45)
            height: width
            visible: {
                if (control.controlStyle === KaakaoControlButton.ControlStyle.Window && 
                    control.controlType === KaakaoControlButton.ControlType.Zoom) {
                    return (control.hovered || control.groupHovered)
                }
                return false
            }

            // Yosemite-Catalina style zoom is drawn as diagonal arrows, or alternatively a plus sign.
            // Let's implement a beautiful high-fidelity diagonal arrows symbol!
            // Line 1: diagonal line
            Rectangle {
                anchors.centerIn: parent
                width: parent.width * 0.9
                height: 1.2
                rotation: 45
                color: Qt.rgba(0, 0, 0, 0.55)
            }
            // Arrowhead 1 (top-right)
            Rectangle {
                x: parent.width - 2.5
                y: 0.5
                width: 2.2
                height: 1.0
                color: Qt.rgba(0, 0, 0, 0.55)
            }
            Rectangle {
                x: parent.width - 1.0
                y: 0.5
                width: 1.0
                height: 2.2
                color: Qt.rgba(0, 0, 0, 0.55)
            }
            // Arrowhead 2 (bottom-left)
            Rectangle {
                x: 0
                y: parent.height - 1.5
                width: 2.2
                height: 1.0
                color: Qt.rgba(0, 0, 0, 0.55)
            }
            Rectangle {
                x: 0
                y: parent.height - 2.7
                width: 1.0
                height: 2.2
                color: Qt.rgba(0, 0, 0, 0.55)
            }
        }
    }
}
