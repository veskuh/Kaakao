import QtQuick
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

/*!
    \qmltype KaakaoRadioButton
    \inqmlmodule Kaakao
    \brief A radio button with classic macOS aesthetic.
    \inherits QtQuick.Controls.RadioButton

    KaakaoRadioButton implements the classic macOS radio button style, featuring 
    a circular raised appearance when unchecked and a sunken, primary-accented 
    appearance with a centered dot when checked.
*/
RadioButton {
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
            radius: width / 2
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
                radius: width / 2

                // Subtle inner shadow for inset look
                Rectangle {
                    anchors { 
                        top: parent.top
                        left: parent.left
                        right: parent.right
                        margins: 2
                    }
                    height: 2
                    color: Qt.rgba(0,0,0,0.15)
                    radius: width / 2
                }
            }
        }

        // Center dot
        Rectangle {
            anchors.centerIn: parent
            width: 4
            height: 4
            radius: 2
            color: "white"
            visible: control.checked
        }

        KaakaoFocusRing {
            target: indicatorBg
            active: control.activeFocus
            focusRadius: width / 2 + 3
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
