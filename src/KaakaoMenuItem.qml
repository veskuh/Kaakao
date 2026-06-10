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

    implicitWidth: (control.visible || (control.parent && !control.parent.visible)) ? Math.max(120, label.implicitWidth + 30 + (shortcutLabel.visible ? shortcutLabel.implicitWidth : 0) + leftPadding + rightPadding) : 0
    implicitHeight: (control.visible || (control.parent && !control.parent.visible)) ? 20 : 0
    
    width: ListView.view ? ListView.view.width : implicitWidth

    padding: 0
    leftPadding: 21 // Classic macOS spacing
    rightPadding: 8

    font: Theme.defaultFont

    contentItem: Item {
        opacity: control.enabled ? 1.0 : 0.5
        Text {
            id: label
            anchors.left: parent.left
            anchors.right: shortcutLabel.visible ? shortcutLabel.left : parent.right
            anchors.rightMargin: shortcutLabel.visible ? 12 : 0
            anchors.verticalCenter: parent.verticalCenter
            text: control.text
            font: control.font
            color: control.highlighted ? Theme.selectionTextActive : Theme.selectionTextInactive
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
            color: control.highlighted ? Theme.selectionTextActive : Theme.sidebarSectionText
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
        opacity: control.enabled ? 1.0 : 0.5

        Text {
            anchors.centerIn: parent
            text: "✓"
            color: control.highlighted ? Theme.selectionTextActive : Theme.selectionTextInactive
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
        color: control.highlighted ? Theme.selectionTextActive : Theme.selectionTextInactive
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
