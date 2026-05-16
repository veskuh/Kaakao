import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

/*!
    \qmltype KaakaoStatusBar
    \inqmlmodule Kaakao
    \brief A structural status bar positioned at the bottom of a window.

    KaakaoStatusBar provides the classic 28px tall macOS footer with 
    a themed background, top border, and internal light-catching highlight.
    It includes a default RowLayout for content.
*/
Rectangle {
    id: control

    /*! \qmlproperty alias spacing
        The spacing between items in the status bar's internal RowLayout.
    */
    property alias spacing: contentLayout.spacing

    /*! \qmlproperty real KaakaoStatusBar::leftPadding
        The left padding for the internal content layout.
    */
    property real leftPadding: 15

    /*! \qmlproperty real KaakaoStatusBar::rightPadding
        The right padding for the internal content layout.
    */
    property real rightPadding: 15

    default property alias content: contentLayout.data

    implicitWidth: 640
    implicitHeight: 28
    
    color: Theme.toolbarGradBottom
    border.color: Theme.toolbarBorder
    border.width: 1

    // Top highlight edge
    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 1
        color: Theme.toolbarHighlight
    }

    RowLayout {
        id: contentLayout
        anchors.fill: parent
        anchors.leftMargin: control.leftPadding
        anchors.rightMargin: control.rightPadding
        spacing: 20
    }
}
