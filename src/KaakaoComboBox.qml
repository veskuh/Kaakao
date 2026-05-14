import QtQuick
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

/*!
    \qmltype KaakaoComboBox
    \inqmlmodule Kaakao
    \brief A classical macOS-style selection control (PopUp button).
    \inherits QtQuick.Controls.ComboBox

    KaakaoComboBox implements the PopUp button style seen in classical macOS.
    It features a gradient button appearance, vertical double-arrow indicator,
    and a custom translucent popup menu.
*/
ComboBox {
    id: control

    implicitWidth: Math.max(120, contentItem.implicitWidth + indicator.width + spacing + padding * 2)
    implicitHeight: 22
    font: Theme.defaultFont
    
    padding: 2
    leftPadding: 8
    rightPadding: 4

    delegate: ItemDelegate {
        id: itemDelegate
        width: control.width
        height: 24
        padding: 0
        
        contentItem: Text {
            text: modelData
            color: control.currentIndex === index ? "#FFFFFF" : Theme.primaryText
            font: control.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
            leftPadding: 8
        }
        
        background: Rectangle {
            anchors.fill: parent
            anchors.margins: 2
            radius: 4
            color: control.currentIndex === index ? Theme.primaryAccent : (itemDelegate.hovered ? Theme.toolButtonHovered : "transparent")
        }
    }

    indicator: Item {
        x: control.width - width - control.rightPadding
        y: (control.height - height) / 2
        width: 12
        height: 12

        Column {
            anchors.centerIn: parent
            spacing: -2
            Text {
                text: "▴"
                font.pixelSize: 10
                color: Theme.primaryText
                opacity: 0.8
            }
            Text {
                text: "▾"
                font.pixelSize: 10
                color: Theme.primaryText
                opacity: 0.8
            }
        }
    }

    contentItem: Text {
        leftPadding: 0
        rightPadding: control.indicator.width + control.spacing

        text: control.displayText
        font: control.font
        color: Theme.primaryText
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
            color: "transparent"

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

        KaakaoFocusRing {
            target: parent
            active: control.activeFocus
            focusRadius: Theme.radiusStandard + 3
        }
    }

    popup: Popup {
        y: control.height + 2
        width: control.width
        implicitHeight: contentItem.implicitHeight + 4
        padding: 2

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex

            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            color: Theme.contentBackground
            opacity: 0.95
            border.color: Theme.sidebarBorder
            border.width: 1
            radius: 6
            
            // Subtle shadow for the popup
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                horizontalOffset: 0
                verticalOffset: 2
                radius: 8
                color: Qt.rgba(0,0,0,0.2)
            }
        }
    }
}
