import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype KaakaoBusyIndicator
    \inqmlmodule Kaakao
    \brief An indeterminate loading indicator.
    \inherits QtQuick.Controls.BusyIndicator

    KaakaoBusyIndicator implements the classic macOS "spinning gear" style
    using a circle of radiating lines that pulse in sequence.
*/
BusyIndicator {
    id: control

    implicitWidth: 16
    implicitHeight: 16

    contentItem: Item {
        id: item
        
        readonly property int tickCount: 12
        property int step: 0

        Timer {
            interval: 80
            running: control.running && control.visible
            repeat: true
            onTriggered: item.step = (item.step + 1) % item.tickCount
        }

        Repeater {
            model: item.tickCount
            delegate: Rectangle {
                id: tick
                width: Math.max(2, control.width * 0.08)
                height: control.height * 0.25
                radius: width / 2
                color: Theme.busyIndicatorTick
                
                // Position in a circle
                x: parent.width / 2 - width / 2
                y: parent.height / 2 - height / 2
                
                transform: [
                    Translate { y: -control.height * 0.3 },
                    Rotation {
                        angle: index * (360 / item.tickCount)
                        origin.x: tick.width / 2
                        origin.y: tick.height / 2 + control.height * 0.3
                    }
                ]

                opacity: {
                    var diff = (index - item.step + item.tickCount) % item.tickCount;
                    return Math.max(0.1, 1.0 - (diff / item.tickCount));
                }
            }
        }
    }
}
