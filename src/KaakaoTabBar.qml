import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype KaakaoTabBar
    \inqmlmodule Kaakao
    \brief A tab bar container with classic macOS aesthetic.
    \inherits QtQuick.Controls.TabBar

    KaakaoTabBar arranges KaakaoTabButton children as a horizontal tab strip.
    The bar draws a 1px bottom border that the selected tab visually merges
    into, creating the classic raised-tab appearance from macOS Yosemite–Catalina.

    Use with a StackLayout for content switching:

    \qml
    KaakaoTabBar {
        id: tabBar
        KaakaoTabButton { text: "General" }
        KaakaoTabButton { text: "Advanced" }
        KaakaoTabButton { text: "Plugins" }
    }

    StackLayout {
        currentIndex: tabBar.currentIndex
        // ... tab content pages ...
    }
    \endqml
*/
TabBar {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    spacing: 0
    padding: 0
    leftPadding: 8

    background: Item {
        implicitHeight: 24

        // Bottom border spanning the full width of the bar
        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: 1
            color: Theme.tabBarBorder
        }
    }
}
