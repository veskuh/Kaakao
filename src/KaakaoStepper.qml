import QtQuick
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

/*!
    \qmltype KaakaoStepper
    \inqmlmodule Kaakao
    \brief A classical macOS-style spin box / stepper control.
    \inherits QtQuick.Controls.SpinBox

    KaakaoStepper implements a text input paired with a vertical pair of
    up/down stepper buttons on the right side, styled to match the
    classic macOS (Yosemite-Catalina) aesthetic.
*/
SpinBox {
    id: control

    implicitWidth: Math.max(120, contentItem.implicitWidth + 16 + 4 + padding * 2)
    implicitHeight: 22

    font: Theme.defaultFont
    editable: true
    padding: 0

    // Ensure the entire control fades when disabled
    opacity: enabled ? 1.0 : Theme.disabledOpacity

    contentItem: TextInput {
        id: textInput
        text: control.displayText
        font: control.font
        color: Theme.primaryText
        selectionColor: Theme.primaryAccent
        selectedTextColor: "white"
        horizontalAlignment: Qt.AlignLeft
        verticalAlignment: Qt.AlignVCenter
        
        // Positioned inside the sunken text well
        x: 6
        y: 0
        width: control.width - 16 - 4 - 10
        height: control.height
        
        readOnly: !control.editable
        validator: control.validator
        inputMethodHints: control.inputMethodHints

        // Select all text on focus for easier editing
        onActiveFocusChanged: {
            if (activeFocus) {
                selectAll()
            }
        }

        onEditingFinished: {
            let val = control.valueFromText(text, control.locale)
            val = Math.max(control.from, Math.min(control.to, val))
            control.value = val
        }
    }

    // Up Stepper Button Indicator
    up.indicator: Item {
        x: control.width - 16
        y: 0
        width: 16
        height: control.height / 2

        // Visual pressed state background overlay
        Rectangle {
            anchors.fill: parent
            anchors.margins: 1
            radius: Theme.radiusSmall - 1
            color: Theme.buttonPressed
            visible: control.up.pressed

            // Mask out bottom corners so only top is rounded
            Rectangle {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height / 2
                color: Theme.buttonPressed
            }
        }

        Canvas {
            id: upArrow
            anchors.centerIn: parent
            width: 6
            height: 3
            opacity: control.up.active ? 1.0 : 0.4

            property color color: Theme.primaryText
            onColorChanged: requestPaint()

            onPaint: {
                var ctx = getContext("2d")
                ctx.reset()
                ctx.fillStyle = color
                ctx.beginPath()
                ctx.moveTo(3, 0)
                ctx.lineTo(6, 3)
                ctx.lineTo(0, 3)
                ctx.closePath()
                ctx.fill()
            }
        }
    }

    // Down Stepper Button Indicator
    down.indicator: Item {
        x: control.width - 16
        y: control.height / 2
        width: 16
        height: control.height / 2

        // Visual pressed state background overlay
        Rectangle {
            anchors.fill: parent
            anchors.margins: 1
            radius: Theme.radiusSmall - 1
            color: Theme.buttonPressed
            visible: control.down.pressed

            // Mask out top corners so only bottom is rounded
            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height / 2
                color: Theme.buttonPressed
            }
        }

        Canvas {
            id: downArrow
            anchors.centerIn: parent
            width: 6
            height: 3
            opacity: control.down.active ? 1.0 : 0.4

            property color color: Theme.primaryText
            onColorChanged: requestPaint()

            onPaint: {
                var ctx = getContext("2d")
                ctx.reset()
                ctx.fillStyle = color
                ctx.beginPath()
                ctx.moveTo(0, 0)
                ctx.lineTo(6, 0)
                ctx.lineTo(3, 3)
                ctx.closePath()
                ctx.fill()
            }
        }
    }

    background: Item {
        // 1. Sunken Text Well (left side)
        Rectangle {
            id: textWell
            width: control.width - 16 - 4
            height: control.height
            color: Theme.contentBackground
            border.color: Theme.textFieldBorder
            border.width: 1
            radius: Theme.radiusSmall

            // Top Inner Shadow for sunken appearance
            Rectangle {
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    margins: 1
                }
                height: 1
                color: Theme.textFieldInnerShadow
                radius: Theme.radiusSmall - 1
            }

            // Focus Ring (surrounds only the text input portion)
            KaakaoFocusRing {
                target: textWell
                active: control.activeFocus
                focusRadius: Theme.radiusSmall + 3
            }
        }

        // 2. Stepper Button Capsule Background (right side)
        Rectangle {
            id: stepperBg
            x: control.width - width
            y: 0
            width: 16
            height: control.height
            radius: Theme.radiusSmall
            border.color: Theme.buttonBorder
            border.width: 1

            // Base silver gradient
            gradient: Gradient {
                GradientStop { position: 0.0; color: Theme.buttonGradTop }
                GradientStop { position: 1.0; color: Theme.buttonGradBottom }
            }

            // Top edge highlight
            Rectangle {
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    margins: 1
                }
                height: 1
                color: Theme.buttonHighlight
                radius: Theme.radiusSmall - 1
            }

            // Horizontal segmented divider separating up and down buttons
            Rectangle {
                anchors.centerIn: parent
                width: parent.width - 2
                height: 1
                color: Theme.buttonBorder
            }
        }
    }
}
