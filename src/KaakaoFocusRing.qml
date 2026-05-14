import QtQuick

Rectangle {
    id: root

    property Item target: parent
    property bool active: target ? target.activeFocus : false
    property real focusRadius: Theme.radiusStandard + 3
    property real ringWidth: 3
    property real ringMargin: -3

    anchors.fill: target
    anchors.margins: ringMargin
    radius: focusRadius
    border.color: Theme.primaryAccent
    border.width: ringWidth
    opacity: active ? 0.4 : 0.0
    color: "transparent"

    Behavior on opacity {
        NumberAnimation { duration: 80 }
    }
}
