import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype KaakaoSplitView
    \inqmlmodule Kaakao
    \brief A resizable multi-pane container.
    \inherits QtQuick.Controls.SplitView

    KaakaoSplitView allows users to resize adjacent panes by dragging a subtle
    divider handle. It provides the characteristic macOS 1px divider line with
    a generous invisible hit area for easy manipulation.
*/
SplitView {
    id: control

    handle: Rectangle {
        implicitWidth: control.orientation === Qt.Horizontal ? 1 : 0
        implicitHeight: control.orientation === Qt.Vertical ? 1 : 0
        color: Theme.sidebarBorder

        // Generous invisible hit area
        Rectangle {
            anchors.centerIn: parent
            width: control.orientation === Qt.Horizontal ? 6 : parent.width
            height: control.orientation === Qt.Vertical ? 6 : parent.height
            color: "transparent"
        }
    }
}
