import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype KaakaoTextArea
    \inqmlmodule Kaakao
    \brief A multi-line text input with a "sunken well" aesthetic.
    \inherits QtQuick.Controls.TextArea

    KaakaoTextArea implements the classic macOS multi-line text input style, 
    featuring a 1px border and a subtle top inner shadow that creates a 
    tangible, sunken appearance. It supports text wrapping and integrates 
    a focus ring when focused.
*/
TextArea {
    id: control

    font: Theme.defaultFont
    color: Theme.primaryText
    selectionColor: Theme.primaryAccent
    selectedTextColor: "white"
    padding: 6
    leftPadding: 8
    rightPadding: 8
    wrapMode: TextEdit.Wrap

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 80
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
