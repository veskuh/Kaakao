import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype KaakaoStatusIndicator
    \inqmlmodule Kaakao
    \brief A small circular indicator used to show connection or operational status.

    KaakaoStatusIndicator provides the classic "LED" look with a base color,
    a darker border, and a subtle top-left highlight to simulate depth.
*/
Rectangle {
    id: control

    implicitWidth: 12
    implicitHeight: 12
    radius: width / 2
    
    color: "#aaaaaa"
    border.color: Qt.darker(color, 1.4)
    border.width: 1

    // Top-left highlight (simulates a light-catching surface)
    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: width * 0.15
        width: parent.width * 0.35
        height: parent.height * 0.35
        radius: width / 2
        color: "white"
        opacity: 0.6
    }
}
