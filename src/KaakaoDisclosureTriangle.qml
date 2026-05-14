import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype KaakaoDisclosureTriangle
    \inqmlmodule Kaakao
    \brief A classical macOS-style disclosure triangle for expanding/collapsing content.
    \inherits QtQuick.Controls.Control

    KaakaoDisclosureTriangle provides the iconic rotating arrow used to toggle
    the visibility of details or sections.
*/
Control {
    id: control

    property bool expanded: false
    property string text: ""

    implicitWidth: row.implicitWidth
    implicitHeight: 18

    contentItem: Row {
        id: row
        spacing: 4
        
        Item {
            width: triangle.width
            height: triangle.height
            anchors.verticalCenter: parent.verticalCenter
            
            Text {
                id: triangle
                text: "▶"
                font.pixelSize: 10
                color: Theme.primaryText
                opacity: control.enabled ? 0.7 : Theme.disabledOpacity
                
                rotation: control.expanded ? 90 : 0
                
                Behavior on rotation {
                    NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
                }

                transformOrigin: Item.Center
                anchors.centerIn: parent
            }
        }

        KaakaoLabel {
            text: control.text
            visible: text.length > 0
            anchors.verticalCenter: parent.verticalCenter
            opacity: control.enabled ? 1.0 : Theme.disabledOpacity
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: control.expanded = !control.expanded
    }
}
