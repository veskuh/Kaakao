import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype KaakaoToolButton
    \inqmlmodule Kaakao
    \brief A toolbar button optimized for structural window headers.
    \inherits QtQuick.Controls.ToolButton

    KaakaoToolButton implements a relief-shaded button style common in macOS
    toolbars. It defaults to TextUnderIcon display and secondary sizing.

    \qml
    KaakaoToolButton {
        text: "Search"
        icon.source: "qrc:/icons/search.svg"
        onClicked: startSearch()
    }
    \endqml
*/
ToolButton {
    id: control

    display: AbstractButton.TextUnderIcon
    spacing: 2
    
    icon.width: 20
    icon.height: 20
    
    font.pixelSize: 11
    
    implicitWidth: Math.max(50, contentItem.implicitWidth + 12)
    implicitHeight: parent ? parent.height : 54

    contentItem: Column {
        spacing: control.spacing
        opacity: control.enabled ? 1.0 : 0.4
        topPadding: 4
        bottomPadding: 4

        Image {
            id: iconItem
            anchors.horizontalCenter: parent.horizontalCenter
            source: control.icon.source
            width: control.icon.width
            height: control.icon.height
            fillMode: Image.PreserveAspectFit
            visible: control.icon.source.toString() !== "" || control.icon.name !== ""
        }

        Text {
            id: textItem
            anchors.horizontalCenter: parent.horizontalCenter
            text: control.text
            font: control.font
            color: Theme.primaryText
            renderType: Text.NativeRendering
            horizontalAlignment: Text.AlignHCenter
            visible: control.text !== ""
        }
    }

    background: Rectangle {
        anchors {
            fill: parent
            margins: 3
        }
        radius: 4
        
        color: {
            if (control.pressed || control.checked) return Theme.toolButtonPressed
            if (control.hovered) return Theme.toolButtonHovered
            return "transparent"
        }
        
        border.color: (control.pressed || control.checked) ? Theme.toolButtonBorder : "transparent"
        border.width: (control.pressed || control.checked) ? 1 : 0

        Behavior on color { ColorAnimation { duration: 50 } }
    }
}
