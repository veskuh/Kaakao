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
    implicitHeight: 22

    handle: Item {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + (control.availableHeight - height) / 2
        width: 18
        height: 18

        Rectangle {
            id: handleRect
            anchors.fill: parent
            radius: width / 2
            border.color: Theme.buttonBorder
            border.width: 1
            color: "transparent"

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

        DropShadow {
            anchors.fill: handleRect
            horizontalOffset: 0
            verticalOffset: 1
            radius: 2
            samples: 16
            color: Theme.buttonShadow
            source: handleRect
            z: -1
        }
    }

    background: Item {
        implicitWidth: 200
        implicitHeight: 22
        
        Rectangle {
            id: trackRect
            anchors.centerIn: parent
            width: parent.width
            height: 6
            radius: 3
            color: Theme.contentBackground
            border.color: Theme.textFieldBorder
            border.width: 1

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
    }
}
