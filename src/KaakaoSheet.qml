import QtQuick
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

/*!
    \qmltype KaakaoSheet
    \inqmlmodule Kaakao
    \brief A modal sheet dialog that slides down from the top edge of a window.
    \inherits QtQuick.Controls.Popup

    KaakaoSheet implements the classic macOS sheet interface. It attaches to the top
    of the parent window/container and slides down with a smooth animation when opened.
*/
Popup {
    id: control

    implicitWidth: 400
    implicitHeight: 200

    parent: Overlay.overlay

    // Center horizontally, stick to top of parent (overlay)
    x: parent ? (parent.width - width) / 2 : 0
    y: 0

    modal: true
    focus: true
    closePolicy: Popup.NoAutoClose

    // Slide down transition
    enter: Transition {
        NumberAnimation {
            property: "y"
            from: -control.height
            to: 0
            duration: 250
            easing.type: Easing.OutQuad
        }
    }

    exit: Transition {
        NumberAnimation {
            property: "y"
            from: 0
            to: -control.height
            duration: 200
            easing.type: Easing.InQuad
        }
    }

    background: Rectangle {
        color: Theme.windowBackground
        border.color: Theme.buttonBorder
        border.width: 1
        
        // Sheets have rounded bottom corners only
        topLeftRadius: 0
        topRightRadius: 0
        bottomLeftRadius: Theme.radiusLarge
        bottomRightRadius: Theme.radiusLarge

        // High-fidelity bottom drop shadow
        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 6
            radius: 16
            samples: 32
            color: Qt.rgba(0, 0, 0, 0.3)
        }
    }

    // Header, content, and footer structure similar to KaakaoDialog
    property string title: ""
    property string text: ""
    property string symbol: ""

    contentItem: Column {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        // Title Area
        KaakaoLabel {
            text: control.title
            font.weight: Font.Bold
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
            visible: control.title.length > 0
        }

        // Body Area
        Row {
            width: parent.width
            spacing: 16
            
            Text {
                text: control.symbol || "💬"
                font.pixelSize: 36
                verticalAlignment: Text.AlignTop
            }

            KaakaoLabel {
                text: control.text
                width: parent.width - 36 - 16
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignTop
                lineHeight: 1.15
            }
        }

        // Spacing
        Item {
            width: 1
            height: 8
        }

        // Action Buttons
        Row {
            anchors.right: parent.right
            spacing: 8
            
            KaakaoButton {
                text: "OK"
                highlighted: true
                onClicked: control.close()
            }
        }
    }
}
