import QtQuick
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

/*!
    \qmltype KaakaoToolBar
    \inqmlmodule Kaakao
    \brief A toolbar with classic macOS aesthetic.
    \inherits QtQuick.Controls.ToolBar

    KaakaoToolBar provides a structural header for windows, set to 54px height
    to comfortably support TextUnderIcon layouts. It features a 1px bottom border.

    \qml
    KaakaoToolBar {
        Row {
            KaakaoToolButton { text: "Back"; icon.name: "go-previous" }
            KaakaoToolButton { text: "Forward"; icon.name: "go-next" }
        }
    }
    \endqml
*/
ToolBar {
    id: control

    implicitHeight: 54
    
    background: Rectangle {
        LinearGradient {
            anchors.fill: parent
            start: Qt.point(0, 0)
            end: Qt.point(0, height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: Theme.toolbarGradTop }
                GradientStop { position: 1.0; color: Theme.toolbarGradBottom }
            }
        }
        
        // Top Highlight
        Rectangle {
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
            }
            height: 1
            color: Theme.toolbarHighlight
        }

        // Structural Border
        Rectangle {
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            height: 1
            color: Theme.toolbarBorder
        }
    }
}
