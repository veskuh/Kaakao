import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype KaakaoTextField
    \inqmlmodule Kaakao
    \brief A text input field with a "sunken well" aesthetic.
    \inherits QtQuick.Controls.TextField

    KaakaoTextField implements the classic macOS text input style, featuring.
    a 1px border and a subtle top inner shadow that creates a tangible, sunken
    appearance. It automatically integrates a focus ring when focused.
*/
TextField {
    id: control

    implicitHeight: 22
    font: Theme.defaultFont
    color: Theme.primaryText
    selectionColor: Theme.primaryAccent
    selectedTextColor: "white"
    padding: 6
    leftPadding: 8
    rightPadding: 8

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 22
        color: Theme.contentBackground
        border.color: Theme.textFieldBorder
        border.width: 1
        radius: Theme.radiusSmall

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
            radius: Theme.radiusSmall - 1
        }

        KaakaoFocusRing {
            target: parent
            active: control.activeFocus
            focusRadius: Theme.radiusSmall + 3
        }
    }
}
