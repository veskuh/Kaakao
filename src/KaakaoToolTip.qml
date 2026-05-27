import QtQuick
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects
import Kaakao

/*!
    \qmltype KaakaoToolTip
    \inqmlmodule Kaakao
    \brief A classical macOS-style tooltip.
    \inherits QtQuick.Controls.ToolTip

    KaakaoToolTip provides a tooltip matching the Yosemite-Catalina macOS aesthetic,
    featuring a translucent dark background in dark mode and a pale yellow background
    in light mode, along with standard shadows and fonts.
*/
ToolTip {
    id: control

    delay: 500
    timeout: 5000

    padding: Theme.paddingSmall
    topPadding: 6
    bottomPadding: 6
    leftPadding: Theme.paddingSmall
    rightPadding: Theme.paddingSmall

    contentItem: Text {
        text: control.text
        font: Theme.defaultFont
        color: Theme.isDarkMode ? "#EAEAEA" : "#000000"
        wrapMode: Text.Wrap
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
    }

    background: Rectangle {
        // macOS Tooltip: pale yellow in light mode, dark translucent gray in dark mode
        color: Theme.isDarkMode ? "#E6282828" : "#FFFEFCD6"
        border.color: Theme.isDarkMode ? "#555555" : "#B8B8B8"
        border.width: 1
        radius: Theme.radiusPopup

        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 2
            radius: 6
            color: Qt.rgba(0, 0, 0, Theme.isDarkMode ? 0.4 : 0.15)
        }
    }
}
