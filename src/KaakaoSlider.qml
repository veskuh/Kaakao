import QtQuick
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

/*!
    \qmltype KaakaoSlider
    \inqmlmodule Kaakao
    \brief A classical macOS-style slider with a sunken track and silver handle.
    \inherits QtQuick.Controls.Slider

    KaakaoSlider implements the "Late-Classical" macOS slider aesthetic, 
    featuring a tangible silver pill-shaped handle and a physically 
    "sunken" track.
*/
Slider {
    id: control

    implicitWidth: 200
    implicitHeight: 22 + (control.showTicks ? 6 : 0) + (control.showValueLabels ? 14 : 0)

    leftPadding: handle.width / 2
    rightPadding: handle.width / 2
    hoverEnabled: true

    property bool showTicks: false
    property real tickInterval: 0
    property bool showValueTooltip: false
    property bool showValueLabels: false

    handle: Item {
        x: control.leftPadding + control.visualPosition * control.availableWidth - width / 2
        y: 2 // Keep centered relative to the 22px control top area
        width: 18
        height: 18

        Rectangle {
            id: handleRect
            anchors.fill: parent
            radius: width / 2
            border.color: Theme.buttonBorder
            border.width: 1
            color: "transparent"

            // Tactile scale on hover/press
            scale: control.pressed ? 0.94 : (control.hovered ? 1.04 : 1.0)
            Behavior on scale {
                NumberAnimation { duration: 80; easing.type: Easing.OutQuad }
            }

            // Core Surface Gradient
            LinearGradient {
                anchors.fill: parent
                anchors.margins: 1
                source: parent
                start: Qt.point(0, 0)
                end: Qt.point(0, height)
                gradient: Gradient {
                    // Subtle curvature: lighter top, darker middle, slightly lighter bottom
                    GradientStop { position: 0.0; color: control.pressed ? Theme.buttonPressed : Theme.buttonGradTop }
                    GradientStop { position: 0.5; color: control.pressed ? Theme.buttonPressed : Qt.rgba(Theme.buttonGradTop.r, Theme.buttonGradTop.g, Theme.buttonGradTop.b, 0.95) }
                    GradientStop { position: 1.0; color: control.pressed ? Theme.buttonPressed : Theme.buttonGradBottom }
                }
            }

            // Integrated curved highlight (Rim light)
            Item {
                anchors.fill: parent
                anchors.margins: 1
                visible: !control.pressed

                Rectangle {
                    id: highlightRing
                    anchors.fill: parent
                    radius: width / 2
                    color: "transparent"
                    border.color: Theme.buttonHighlight
                    border.width: 1
                    visible: false
                }

                LinearGradient {
                    id: highlightMask
                    anchors.fill: parent
                    start: Qt.point(0, 0)
                    end: Qt.point(0, height)
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "white" }
                        GradientStop { position: 0.4; color: "transparent" }
                    }
                    visible: false
                }

                OpacityMask {
                    anchors.fill: parent
                    source: highlightRing
                    maskSource: highlightMask
                }
            }
        }

        // Value Bubble Tooltip
        Rectangle {
            id: valueBubble
            anchors.bottom: parent.top
            anchors.bottomMargin: 8
            anchors.horizontalCenter: parent.horizontalCenter
            width: Math.max(28, bubbleText.implicitWidth + 10)
            height: bubbleText.implicitHeight + 4
            radius: 4
            color: Theme.isDarkMode ? "#E63C3C3C" : "#E6222222"
            border.color: Theme.isDarkMode ? "#666666" : "#111111"
            border.width: 1
            z: 10

            opacity: control.showValueTooltip && (control.pressed || control.hovered) ? 1.0 : 0.0
            visible: opacity > 0.0

            Behavior on opacity {
                NumberAnimation { duration: 100 }
            }

            // Pointer tip pointing down to the knob
            Rectangle {
                anchors.top: parent.bottom
                anchors.topMargin: -3
                anchors.horizontalCenter: parent.horizontalCenter
                width: 6
                height: 6
                rotation: 45
                color: parent.color
                border.color: parent.border.color
                border.width: 1
                z: -1
            }

            Text {
                id: bubbleText
                anchors.centerIn: parent
                text: control.value.toFixed(control.stepSize > 0 && (control.stepSize % 1 !== 0) ? 1 : 0)
                font.family: Theme.defaultFont.family
                font.pixelSize: 10
                font.bold: true
                color: "#FFFFFF"
                renderType: Text.NativeRendering
            }
        }

        // Circular Focus Ring around the handle
        KaakaoFocusRing {
            target: handleRect
            active: control.activeFocus
            focusRadius: handleRect.radius + 3
        }

        DropShadow {
            anchors.fill: handleRect
            horizontalOffset: 0
            verticalOffset: control.pressed ? 2 : 1
            radius: control.pressed ? 3 : (control.hovered ? 2.5 : 2.0)
            samples: 16
            color: Theme.buttonShadow
            source: handleRect
            z: -1

            Behavior on verticalOffset { NumberAnimation { duration: 80 } }
            Behavior on radius { NumberAnimation { duration: 80 } }
        }
    }

    background: Item {
        implicitWidth: 200
        implicitHeight: control.implicitHeight
        
        Rectangle {
            id: trackRect
            x: control.leftPadding
            y: 8 // Keep aligned with the top handle
            width: control.availableWidth
            height: 6
            radius: 3
            color: Theme.contentBackground
            border.color: Theme.textFieldBorder
            border.width: 1

            // Highlighted progress track (active region)
            Rectangle {
                id: highlightTrack
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height - 2
                anchors.leftMargin: 1
                width: Math.max(0, control.visualPosition * parent.width - 2)
                radius: 2
                gradient: Gradient {
                    GradientStop { position: 0.0; color: Theme.accentGradTop }
                    GradientStop { position: 1.0; color: Theme.accentGradBottom }
                }
                visible: control.visualPosition > 0
            }

            // Top Inner Shadow (Sunken Well effect)
            Rectangle {
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    margins: 1
                }
                height: 1
                color: Theme.textFieldInnerShadow
                radius: 2
            }
        }

        // Discrete Stepped Ticks
        Item {
            id: ticksContainer
            anchors.top: trackRect.bottom
            anchors.topMargin: 3
            anchors.left: parent.left
            anchors.leftMargin: control.leftPadding
            width: control.availableWidth
            height: 3
            visible: control.showTicks && ticksRepeater.count > 1

            Repeater {
                id: ticksRepeater
                model: {
                    if (!control.showTicks) return 0;
                    let range = control.to - control.from;
                    if (range <= 0) return 0;
                    let interval = control.tickInterval > 0 ? control.tickInterval : control.stepSize;
                    if (interval <= 0) return 0;
                    return Math.floor(range / interval) + 1;
                }

                delegate: Rectangle {
                    x: Math.round(index * (ticksContainer.width - 1) / (ticksRepeater.count - 1))
                    width: 1
                    height: 3
                    color: Theme.secondaryText
                }
            }
        }

        // Min/Max Value Labels
        Item {
            id: labelsContainer
            anchors.top: ticksContainer.visible ? ticksContainer.bottom : trackRect.bottom
            anchors.topMargin: ticksContainer.visible ? 2 : 4
            anchors.left: parent.left
            anchors.leftMargin: control.leftPadding
            width: control.availableWidth
            height: 14
            visible: control.showValueLabels

            KaakaoLabel {
                anchors.horizontalCenter: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: control.from.toString()
                role: KaakaoLabel.Role.Small
                color: Theme.secondaryText
                horizontalAlignment: Text.AlignHCenter
            }

            KaakaoLabel {
                anchors.horizontalCenter: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: control.to.toString()
                role: KaakaoLabel.Role.Small
                color: Theme.secondaryText
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
}
