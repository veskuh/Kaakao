import QtQuick
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

/*!
    \qmltype KaakaoSegmentedControl
    \inqmlmodule Kaakao
    \brief A segmented control for selecting between multiple options.
    \inherits QtQuick.Controls.Control

    KaakaoSegmentedControl implements the quintessential macOS segmented control,
    featuring a unified outer border, shared dividing lines, and an animated 
    selection indicator.
*/
Control {
    id: control

    property alias model: repeater.model
    property int currentIndex: 0
    
    implicitWidth: row.implicitWidth + leftPadding + rightPadding
    implicitHeight: 22 + topPadding + bottomPadding
    
    padding: 0
    
    background: Rectangle {
        id: bg
        border.color: Theme.buttonBorder
        border.width: 1
        radius: Theme.radiusSmall
        color: Theme.buttonGradBottom // Base color

        // Selection Indicator (Sliding)
        Rectangle {
            id: selectionIndicator
            // Bind to repeater.count to ensure it re-evaluates when items are created
            property Item currentItem: {
                if (repeater.count > 0 && control.currentIndex >= 0 && control.currentIndex < repeater.count) {
                    return repeater.itemAt(control.currentIndex)
                }
                return null
            }
            
            visible: currentItem !== null
            x: currentItem ? currentItem.x + (control.currentIndex === 0 ? 1 : 0) : 0
            y: 1
            width: currentItem ? currentItem.width - (control.currentIndex === 0 ? 2 : 1) : 0
            height: parent.height - 2
            radius: Theme.radiusSmall - 1
            z: 0

            LinearGradient {
                anchors.fill: parent
                anchors.margins: 1
                start: Qt.point(0, 0)
                end: Qt.point(0, height)
                gradient: Gradient {
                    GradientStop { 
                        position: 0.0
                        color: Theme.isDarkMode ? "#555" : "#FFF" 
                    }
                    GradientStop { 
                        position: 1.0
                        color: Theme.isDarkMode ? "#333" : "#EEE" 
                    }
                }
            }
            
            // Top highlight for the selected segment
            Rectangle {
                anchors { top: parent.top; left: parent.left; right: parent.right; margins: 1 }
                height: 1
                color: Theme.buttonHighlight
                radius: Theme.radiusSmall - 1
            }

            Behavior on x { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }
            Behavior on width { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }
        }

        KaakaoFocusRing {
            target: bg
            active: control.activeFocus
            focusRadius: Theme.radiusSmall + 3
        }
    }

    contentItem: Row {
        id: row
        spacing: 0
        
        Repeater {
            id: repeater
            
            delegate: Item {
                implicitWidth: Math.max(60, label.implicitWidth + 20)
                implicitHeight: 22
                
                KaakaoLabel {
                    id: label
                    anchors.centerIn: parent
                    text: modelData
                    font: Theme.defaultFont
                    color: Theme.primaryText
                    opacity: control.enabled ? 1.0 : Theme.disabledOpacity
                }

                // Divider (except for the last item)
                Rectangle {
                    anchors { right: parent.right; top: parent.top; bottom: parent.bottom; topMargin: 1; bottomMargin: 1 }
                    width: 1
                    color: Theme.buttonBorder
                    visible: index < repeater.count - 1
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        control.currentIndex = index
                        control.forceActiveFocus()
                    }
                }
            }
        }
    }
    
    Keys.onLeftPressed: if (currentIndex > 0) currentIndex--
    Keys.onRightPressed: if (currentIndex < repeater.count - 1) currentIndex++
}
