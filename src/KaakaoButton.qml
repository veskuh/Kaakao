import QtQuick
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

/*!
    \qmltype KaakaoButton
    \inqmlmodule Kaakao
    \brief A push-button with classic macOS aesthetic.
    \inherits QtQuick.Controls.Button

    The KaakaoButton component implements the classic macOS (Yosemite-Catalina) look and feel,
    featuring a subtle vertical gradient, a 1px border, and a top-edge highlight.
*/
Button {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightPadding,
                            implicitContentWidth + leftPadding + rightPadding, 80)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding, 22)

    padding: 2
    leftPadding: 12
    rightPadding: 12

    font: Theme.defaultFont

    contentItem: Label {
        text: control.text
        font: control.font
        color: control.highlighted ? "#FFFFFF" : Theme.primaryText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        renderType: Text.NativeRendering
    }

    background: Rectangle {
        id: bg
        implicitWidth: 80
        implicitHeight: 22
        radius: Theme.radiusStandard
        
        // Border and base color
        color: Theme.isDarkMode ? "#252525" : "#FFFFFF" // Fallback color
        border.color: control.highlighted ? Theme.accentBorder : Theme.buttonBorder
        border.width: 1

        // Main Gradient Surface (as a child to ensure border is on top)
        Rectangle {
            anchors.fill: parent
            anchors.margins: 1
            radius: bg.radius - 0.5
            clip: true
            
            gradient: Gradient {
                GradientStop { 
                    position: 0.0
                    color: {
                        if (control.pressed) return control.highlighted ? Theme.accentGradBottom : Theme.buttonPressed
                        return control.highlighted ? Theme.accentGradTop : Theme.buttonGradTop
                    }
                }
                GradientStop { 
                    position: 1.0
                    color: {
                        if (control.pressed) return control.highlighted ? Theme.accentGradBottom : Theme.buttonPressed
                        return control.highlighted ? Theme.accentGradBottom : Theme.buttonGradBottom
                    }
                }
            }

            // Top-edge inner highlight (simulates light catch)
            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: 1
                color: control.highlighted ? Qt.rgba(1,1,1,0.2) : Theme.buttonHighlight
                visible: !control.pressed
            }
            
            // Subtle bottom shadow inside the border
            Rectangle {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: 1
                color: control.highlighted ? "transparent" : Theme.buttonShadow
                visible: !control.pressed
            }
        }

        // Focus Ring
        KaakaoFocusRing {
            anchors.fill: parent
            anchors.margins: -3
            visible: control.activeFocus
        }
    }
}
