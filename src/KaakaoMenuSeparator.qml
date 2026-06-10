import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype KaakaoMenuSeparator
    \inqmlmodule Kaakao
    \brief A visual separator between items in a KaakaoMenu.
    \inherits QtQuick.Controls.MenuSeparator
*/
MenuSeparator {
    id: control

    implicitWidth: (control.visible || (control.parent && !control.parent.visible)) ? (contentItem.implicitWidth + leftPadding + rightPadding) : 0
    implicitHeight: (control.visible || (control.parent && !control.parent.visible)) ? 11 : 0
    
    width: ListView.view ? ListView.view.width : implicitWidth

    padding: 0
    topPadding: 5
    bottomPadding: 5

    contentItem: Rectangle {
        implicitWidth: 100
        implicitHeight: 1
        color: Theme.separatorDark
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 4
        anchors.rightMargin: 4
    }

    background: Item {
        implicitHeight: 11
    }
}
