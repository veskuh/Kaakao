import QtQuick
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

/*!
    \qmltype Button
    \inqmlmodule Kaakao
    \brief A push-button with classic macOS aesthetic.
    \inherits QtQuick.Controls.Button

    The Button component implements the classic macOS (Yosemite-Catalina) look and feel,
    featuring a subtle gradient, top inner highlight, and a soft drop shadow.
    It supports standard button states like pressed and focused.
*/
Button {
    id: control

    implicitWidth: Math.max(80, contentItem.implicitWidth + 20)
    implicitHeight: 22 // Classic compact macOS height
    contentItem: Text {
        text: control.text
        font: Theme.defaultFont
        color: Theme.primaryText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Item {
        Rectangle {
            id: bgRect
            anchors.fill: parent
            radius: Theme.radiusStandard
            border.color: Theme.buttonBorder
            border.width: 1
            color: "transparent" // Handled by gradient

            LinearGradient {
                anchors.fill: parent
                anchors.margins: 1
                source: parent
                start: Qt.point(0, 0)
                end: Qt.point(0, height)
                gradient: Gradient {
                    GradientStop { 
                        position: 0.0
                        color: control.pressed ? Theme.buttonPressed : Theme.buttonGradTop 
                    }
                    GradientStop { 
                        position: 1.0
                        color: control.pressed ? Theme.buttonPressed : Theme.buttonGradBottom 
                    }
                }
            }

            // Top Inner Highlight
            Rectangle {
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    margins: 1
                }
                height: 1
                color: Theme.buttonHighlight
                visible: !control.pressed
            }
        }

        // Subtle Drop Shadow
        DropShadow {
            anchors.fill: bgRect
            horizontalOffset: 0
            verticalOffset: 1
            radius: Theme.isDarkMode ? 1 : 0
            samples: 16
            color: Theme.buttonShadow
            source: bgRect
            z: -1
        }

        // Focus Ring
        Rectangle {
            anchors.fill: parent
            anchors.margins: -3
            radius: Theme.radiusStandard + 3
            border.color: Theme.primaryAccent
            border.width: 3
            opacity: control.activeFocus ? 0.4 : 0.0
            color: "transparent"
            Behavior on opacity { NumberAnimation { duration: 80 } }
        }
    }
}
