import QtQuick
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

/*!
    \qmltype KaakaoCheckBox
    \inqmlmodule Kaakao
    \brief A checkbox with classic macOS aesthetic.
    \inherits QtQuick.Controls.CheckBox

    KaakaoCheckBox implements the classic macOS checkbox style, featuring a 
    raised appearance when unchecked and a sunken, primary-accented appearance 
    when checked.
*/
CheckBox {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftPadding + rightPadding,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topPadding + bottomPadding,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 4
    spacing: 8

    font: Theme.defaultFont

    indicator: Item {
        implicitWidth: 14
        implicitHeight: 14
        x: control.leftPadding
        y: parent.height / 2 - height / 2

        Rectangle {
            id: indicatorBg
            anchors.fill: parent
            radius: 3
            border.color: control.checked ? Theme.accentBorder : Theme.buttonBorder
            border.width: 1

            // Gradient for "raised" look when unchecked
            LinearGradient {
                anchors.fill: parent
                anchors.margins: 1
                visible: !control.checked
                start: Qt.point(0, 0)
                end: Qt.point(0, height)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: Theme.buttonGradTop }
                    GradientStop { position: 1.0; color: Theme.buttonGradBottom }
                }
            }

            // Fill for "inset" look when checked
            Rectangle {
                anchors.fill: parent
                anchors.margins: 1
                visible: control.checked
                color: Theme.primaryAccent
                radius: 2

                // Subtle inner shadow for inset look
                Rectangle {
                    anchors { top: parent.top; left: parent.left; right: parent.right }
                    height: 1
                    color: Qt.rgba(0,0,0,0.2)
                    radius: 2
                }
            }
        }

        // Checkmark (simple drawn path)
        Item {
            anchors.fill: parent
            visible: control.checked

            Rectangle {
                width: 5
                height: 2
                color: "white"
                rotation: 45
                x: 3
                y: 7
            }
            Rectangle {
                width: 8
                height: 2
                color: "white"
                rotation: -45
                x: 5
                y: 6
            }
        }

        KaakaoFocusRing {
            target: indicatorBg
            active: control.activeFocus
            focusRadius: 6
        }
    }

    contentItem: Text {
        leftPadding: control.indicator.width + control.spacing
        text: control.text
        font: control.font
        color: Theme.primaryText
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
    }
}
