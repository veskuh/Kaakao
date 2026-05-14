import QtQuick
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

/*!
    \qmltype KaakaoProgressBar
    \inqmlmodule Kaakao
    \brief A classical macOS-style progress bar with authentic Aqua blue styling.
    \inherits QtQuick.Controls.ProgressBar

    KaakaoProgressBar implements the iconic Aqua-style progress bar, featuring
    a multi-layered gel gradient for a true high-fidelity macOS appearance.
*/
ProgressBar {
    id: control

    implicitWidth: 200
    implicitHeight: 10

    contentItem: Item {
        implicitWidth: 200
        implicitHeight: 10

        // Use a mask to ensure correct rounding at both ends during fill
        Item {
            id: maskContainer
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            clip: true
            width: control.indeterminate ? parent.width : control.visualPosition * parent.width

            Rectangle {
                width: control.availableWidth
                height: parent.height
                radius: height / 2
                color: "black"

                // 1. Base Rich Aqua Gradient (Deep volume)
                LinearGradient {
                    anchors.fill: parent
                    source: parent
                    start: Qt.point(0, 0)
                    end: Qt.point(0, height)
                    visible: !control.indeterminate
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#54A9FF" }
                        GradientStop { position: 0.4; color: "#007AFF" }
                        GradientStop { position: 1.0; color: "#005BBF" }
                    }
                }

                // Indeterminate "Barber Pole" Animation
                Item {
                    anchors.fill: parent
                    visible: control.indeterminate
                    clip: true

                    Row {
                        id: stripeRow
                        x: -40
                        spacing: 0
                        Repeater {
                            model: Math.ceil(control.width / 20) + 6
                            Rectangle {
                                width: 20
                                height: control.height * 2
                                y: (control.height - height) / 2
                                color: index % 2 === 0 ? "#007AFF" : "#54A9FF"
                                rotation: 20
                            }
                        }

                        NumberAnimation on x {
                            from: -60
                            to: -20
                            duration: 800
                            loops: Animation.Infinite
                            running: control.indeterminate && control.visible
                        }
                    }
                }

                // 2. Translucent "Gel" Gloss (Upper highlight)
                Rectangle {
                    anchors {
                        top: parent.top
                        left: parent.left
                        right: parent.right
                        margins: 1
                    }
                    height: parent.height * 0.45
                    radius: height / 2
                    opacity: 0.5
                    
                    LinearGradient {
                        anchors.fill: parent
                        source: parent
                        start: Qt.point(0, 0)
                        end: Qt.point(0, height)
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: "#FFFFFF" }
                            GradientStop { position: 1.0; color: "transparent" }
                        }
                    }
                }

                // 3. Shimmer Effect (Determinate only)
                Rectangle {
                    id: shimmer
                    width: 60
                    height: parent.height
                    opacity: 0.2
                    visible: !control.indeterminate && control.visible && control.value > 0
                    
                    LinearGradient {
                        anchors.fill: parent
                        start: Qt.point(0, 0)
                        end: Qt.point(width, 0)
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: "transparent" }
                            GradientStop { position: 0.5; color: "white" }
                            GradientStop { position: 1.0; color: "transparent" }
                        }
                    }

                    SequentialAnimation on x {
                        loops: Animation.Infinite
                        running: shimmer.visible
                        
                        NumberAnimation {
                            from: -shimmer.width
                            to: control.availableWidth
                            duration: 1500
                            easing.type: Easing.InOutSine
                        }
                        PauseAnimation { duration: 2000 }
                    }
                }

                // 4. Subtle bottom rim light
                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: 1
                    color: Qt.rgba(1, 1, 1, 0.15)
                    opacity: 0.5
                }
            }
        }
    }

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 10
        color: Theme.isDarkMode ? "#121212" : "#D0D0D0"
        radius: height / 2
        border.color: Theme.isDarkMode ? "#000000" : "#B0B0B0"
        border.width: 1

        // Inset Shadow Effect
        Rectangle {
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: 1
            }
            height: 1
            color: Qt.rgba(0, 0, 0, Theme.isDarkMode ? 0.4 : 0.1)
            radius: height / 2
        }
    }
}
