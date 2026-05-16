import QtQuick

/*!
    \qmltype KaakaoSeparator
    \inqmlmodule Kaakao
    \brief A subtle etched line used to divide or group UI elements.

    KaakaoSeparator provides the characteristic dual-line (dark/light) separator
    found in classical macOS layouts. It supports both horizontal and vertical
    orientations.
*/
Item {
    id: control

    /*! \qmlproperty enumeration KaakaoSeparator::orientation
        The orientation of the separator. Can be \c Qt.Horizontal or \c Qt.Vertical.
    */
    property int orientation: Qt.Horizontal

    implicitWidth: orientation === Qt.Horizontal ? 100 : 2
    implicitHeight: orientation === Qt.Horizontal ? 2 : 100

    Rectangle {
        id: darkLine
        color: Theme.separatorDark
        width: control.orientation === Qt.Horizontal ? parent.width : 1
        height: control.orientation === Qt.Horizontal ? 1 : parent.height
        anchors.top: parent.top
        anchors.left: parent.left
    }

    Rectangle {
        id: lightLine
        color: Theme.separatorLight
        width: control.orientation === Qt.Horizontal ? parent.width : 1
        height: control.orientation === Qt.Horizontal ? 1 : parent.height
        anchors.top: control.orientation === Qt.Horizontal ? darkLine.bottom : parent.top
        anchors.left: control.orientation === Qt.Horizontal ? parent.left : darkLine.right
    }
}
