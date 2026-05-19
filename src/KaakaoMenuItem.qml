import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype KaakaoMenuItem
    \inqmlmodule Kaakao
    \brief An item within a KaakaoMenu.
    \inherits QtQuick.Controls.MenuItem

    KaakaoMenuItem implements the standard macOS menu item look, including
    highlight states, checkmarks for checkable items, and support for submenus.
*/
MenuItem {
    id: control

    /*! \qmlproperty string KaakaoMenuItem::shortcut
        The shortcut text to display on the right side of the menu item (e.g., "⌘N").
    */
    property string shortcut: ""

    implicitWidth: Math.max(120, label.implicitWidth + 30 + (shortcutLabel.visible ? shortcutLabel.implicitWidth : 0) + leftPadding + rightPadding)
    implicitHeight: 20
    
    width: ListView.view ? ListView.view.width : implicitWidth

    padding: 0
    leftPadding: 21 // Classic macOS spacing
    rightPadding: 8

    font: Theme.defaultFont

    contentItem: Item {
        Text {
            id: label
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            text: control.text
            font: control.font
            color: control.highlighted ? "#FFFFFF" : Theme.primaryText
            elide: Text.ElideRight
            renderType: Text.NativeRendering
        }

        // Shortcut display
        Text {
            id: shortcutLabel
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            text: control.shortcut
            font: control.font
            color: control.highlighted ? "#FFFFFF" : (Theme.isDarkMode ? "#8E8E8E" : "#6E6E6E")
            visible: text !== ""
            renderType: Text.NativeRendering
        }
    }

    indicator: Item {
        x: 5
        y: (control.height - height) / 2
        width: 12
        height: 12
        visible: control.checkable && control.checked

        Text {
            anchors.centerIn: parent
            text: "✓"
            color: control.highlighted ? "#FFFFFF" : Theme.primaryText
            font.pixelSize: 11
            renderType: Text.NativeRendering
        }
    }

    arrow: Text {
        x: control.width - width - 6
        y: (control.height - height) / 2
        visible: control.subMenu
        text: "▶"
        font.pixelSize: 9
        color: control.highlighted ? "#FFFFFF" : Theme.primaryText
        renderType: Text.NativeRendering
    }

    background: Rectangle {
        visible: control.highlighted
        color: Theme.primaryAccent
        radius: 3
        anchors.fill: parent
        anchors.margins: 1
        anchors.leftMargin: 2
        anchors.rightMargin: 2
    }
}
