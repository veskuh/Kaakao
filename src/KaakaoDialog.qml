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
    implicitWidth: 360
    modal: true

    x: {
        let parentItem = control.parent
        let w = parentItem ? parentItem.Window.window : null
        if (w) return Math.round((w.width - width) / 2)
        if (parentItem) return Math.round((parentItem.width - width) / 2)
        return 0
    }
    y: {
        let parentItem = control.parent
        let w = parentItem ? parentItem.Window.window : null
        if (w) return Math.round((w.height - height) / 2)
        if (parentItem) return Math.round((parentItem.height - height) / 2)
        return 0
    }
    
    /*! \qmlproperty string KaakaoDialog::text
        The message text to display in the dialog.
    */
    property string text: ""

    /*! \qmlproperty string KaakaoDialog::symbol
        A symbol or emoji to display as the dialog's icon.
    */
    property string symbol: ""

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

    header: Item {
        implicitHeight: titleLabel.implicitHeight + 24
        visible: control.title.length > 0
        KaakaoLabel {
            id: titleLabel
            anchors.centerIn: parent
            text: control.title
            font.weight: Font.Bold
            font.pixelSize: 14
        }
    }

    contentItem: Row {
        spacing: 20
        padding: 24
        topPadding: control.title.length > 0 ? 0 : 24

        Text {
            text: control.symbol || "⚠️"
            font.pixelSize: 56
            visible: true
            verticalAlignment: Text.AlignTop
        }

        KaakaoLabel {
            text: control.text
            width: parent.width - 56 - 20 - 48
            wrapMode: Text.WordWrap
            verticalAlignment: Text.AlignTop
            lineHeight: 1.2
        }
    }

    footer: DialogButtonBox {
        background: Item {}
        alignment: Qt.AlignRight
        padding: 16
        spacing: 12
        
        delegate: KaakaoButton {
            highlighted: DialogButtonBox.buttonRole === DialogButtonBox.AcceptRole || DialogButtonBox.buttonRole === DialogButtonBox.YesRole
        }
    }
}
