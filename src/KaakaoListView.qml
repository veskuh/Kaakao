import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype KaakaoListView
    \inqmlmodule Kaakao
    \brief A desktop-optimized data list container.

    KaakaoListView wraps the standard Qt ListView. It disables mobile-style 
    flick physics in favor of strict desktop wheel scrolling, frames the content 
    with a 1px classic border, and enables keyboard navigation by default.
*/
ListView {
    id: control

    // Desktop Interaction Defaults
    interactive: false // Disable mobile touch-drag flicking
    boundsBehavior: Flickable.StopAtBounds // No rubber-band bouncing
    clip: true
    focus: true
    keyNavigationEnabled: true
    highlightMoveDuration: 0 // Desktop selection jumps instantly, it does not slide

    // Enforce an outer structural frame (Sunken well aesthetic)
    Rectangle {
        anchors.fill: parent
        z: -1 // Place behind the scrollable content
        color: Theme.contentBackground
        border.color: Theme.textFieldBorder
        border.width: 1
    }

    // Optional: Inner top shadow to create the "sunken well" depth
    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 3
        z: 1 // Place above content
        gradient: Gradient {
            GradientStop { position: 0.0; color: Theme.isDarkMode ? "#33000000" : "#1A000000" }
            GradientStop { position: 1.0; color: "transparent" }
        }
    }
}
