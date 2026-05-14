import QtQuick
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

/*!
    \qmltype KaakaoDialog
    \inqmlmodule Kaakao
    \brief A modal dialog with classic macOS styling.
    \inherits QtQuick.Controls.Dialog

    KaakaoDialog provides a refined modal interface with deep drop shadows,
    a larger corner radius, and integrated header styling using KaakaoLabel.
*/
Dialog {
    id: control
    implicitWidth: Math.max(header.implicitWidth, contentItem.implicitWidth) + leftPadding + rightPadding
    
    background: Rectangle {
        color: Theme.windowBackground
        border.color: Theme.buttonBorder
        border.width: 1
        radius: Theme.radiusLarge
        
        // Classic macOS dialog shadow is deeper than buttons
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            samples: 24
            color: Qt.rgba(0,0,0,0.3)
        }
    }

    header: KaakaoLabel {
        text: control.title
        role: KaakaoLabel.Role.Header
        horizontalAlignment: Text.AlignHCenter
        padding: 12
        visible: control.title.length > 0
    }

    footer: DialogButtonBox {
        background: Rectangle {
            color: "transparent"
        }
        alignment: Qt.AlignHCenter
        padding: 12
        
        // We will need to style the buttons in the button box 
        // but for now, we'll let them inherit or we'll use custom buttons.
    }
}
