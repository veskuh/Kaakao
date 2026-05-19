import QtQuick
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

/*!
    \qmltype KaakaoMenu
    \inqmlmodule Kaakao
    \brief A classical macOS-style popup menu.
    \inherits QtQuick.Controls.Menu

    KaakaoMenu provides a translucent, rounded-corner menu with a subtle drop shadow,
    consistent with the Yosemite-Catalina macOS aesthetic.
*/
Menu {
    id: control

    implicitWidth: Math.max(150, contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight, contentHeight + topPadding + bottomPadding)

    margins: 0
    padding: 1 // Tight macOS border padding

    delegate: KaakaoMenuItem { }

    background: Rectangle {
        implicitWidth: 150
        implicitHeight: 30
        color: Theme.contentBackground
        opacity: 0.98
        border.color: Theme.sidebarBorder
        border.width: 1
        radius: 5

        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 4
            radius: 12
            color: Qt.rgba(0,0,0,0.3)
        }
    }

    contentItem: ListView {
        implicitWidth: contentWidth
        implicitHeight: contentHeight
        model: control.contentModel
        interactive: Window.window
                     ? contentHeight > Window.window.height
                     : false
        clip: true
        currentIndex: control.currentIndex

        ScrollIndicator.vertical: ScrollIndicator { }
    }
}
