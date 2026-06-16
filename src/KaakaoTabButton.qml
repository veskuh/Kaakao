import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype KaakaoTabButton
    \inqmlmodule Kaakao
    \brief A tab button with classic macOS raised-tab aesthetic.
    \inherits QtQuick.Controls.TabButton

    KaakaoTabButton implements the Yosemite–Catalina era tab style where the
    selected tab visually merges into the content area below. It is designed
    for use inside a KaakaoTabBar.

    \qml
    KaakaoTabBar {
        KaakaoTabButton { text: "General" }
        KaakaoTabButton { text: "Advanced" }
    }
    \endqml
*/
TabButton {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding, 70)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding, 24)

    padding: 2
    leftPadding: 14
    rightPadding: 14

    font.family: Theme.defaultFont.family
    font.pixelSize: Theme.defaultFont.pixelSize
    font.weight: control.checked ? Font.DemiBold : Font.Normal

    contentItem: Label {
        text: control.text
        font: control.font
        color: Theme.primaryText
        opacity: control.checked ? 1.0 : 0.7
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        renderType: Text.NativeRendering

        Behavior on opacity { NumberAnimation { duration: 100 } }
    }

    background: Item {
        implicitWidth: 70
        implicitHeight: 24

        // Main tab shape — top corners rounded, bottom corners square
        Rectangle {
            id: bg
            anchors.fill: parent
            topLeftRadius: Theme.radiusStandard
            topRightRadius: Theme.radiusStandard
            bottomLeftRadius: 0
            bottomRightRadius: 0

            border.color: Theme.buttonBorder
            border.width: 1
            color: "transparent"

            // Gradient fill inside the border
            Rectangle {
                anchors.fill: parent
                anchors.margins: 1
                anchors.bottomMargin: control.checked ? 0 : 1
                topLeftRadius: bg.topLeftRadius > 0 ? bg.topLeftRadius - 1 : 0
                topRightRadius: bg.topRightRadius > 0 ? bg.topRightRadius - 1 : 0
                bottomLeftRadius: 0
                bottomRightRadius: 0
                clip: true

                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: {
                            if (control.pressed) return control.checked ? Theme.buttonPressed : Theme.tabInactivePressed
                            return control.checked ? Theme.tabActiveGradTop : Theme.tabInactiveGradTop
                        }
                    }
                    GradientStop {
                        position: 1.0
                        color: {
                            if (control.pressed) return control.checked ? Theme.buttonPressed : Theme.tabInactivePressed
                            return control.checked ? Theme.tabActiveGradBottom : Theme.tabInactiveGradBottom
                        }
                    }
                }

                // Top-edge inner highlight
                Rectangle {
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 1
                    color: Theme.buttonHighlight
                    visible: control.checked && !control.pressed
                }
            }

            // Bottom accent line when selected
            Rectangle {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 1
                anchors.rightMargin: 1
                height: 2
                color: control.checked ? Theme.primaryAccent : "transparent"
                visible: control.checked
            }
        }

        // Focus Ring
        KaakaoFocusRing {
            target: bg
            active: control.activeFocus
            focusRadius: Theme.radiusStandard + 3
        }
    }
}
