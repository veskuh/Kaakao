import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype KaakaoGridView
    \inqmlmodule Kaakao
    \brief A scrollable grid view for displaying thumbnail collections.

    KaakaoGridView wraps a standard Qt GridView in a themed ScrollView.
    It provides desktop-optimized interactions, including disabled flicking
    and consistent spatial logic.
*/
ScrollView {
    id: control

    /*! \qmlproperty var KaakaoGridView::model
        The data model for the grid.
    */
    property alias model: gridView.model

    /*! \qmlproperty Component KaakaoGridView::delegate
        The delegate used to render items in the grid.
    */
    property alias delegate: gridView.delegate

    /*! \qmlproperty int KaakaoGridView::currentIndex
        The index of the currently selected item.
    */
    property alias currentIndex: gridView.currentIndex

    /*! \qmlproperty real KaakaoGridView::cellWidth
        The width of each cell in the grid.
    */
    property alias cellWidth: gridView.cellWidth

    /*! \qmlproperty real KaakaoGridView::cellHeight
        The height of each cell in the grid.
    */
    property alias cellHeight: gridView.cellHeight

    /*! \qmlproperty bool KaakaoGridView::interactive
        Whether the user can interact with the grid (scrolling, flicking).
        Defaults to true for desktop mouse wheel and touchpad support.
    */
    property alias interactive: gridView.interactive

    clip: true
    contentWidth: availableWidth

    // Access to the internal GridView
    property alias gridView: gridView

    background: Rectangle {
        color: Theme.contentBackground
        border.color: Theme.textFieldBorder
        border.width: 1
    }

    GridView {
        id: gridView
        anchors.fill: parent
        anchors.margins: 1
        
        boundsBehavior: Flickable.StopAtBounds
        
        keyNavigationEnabled: true
        focus: true

        // Inner top shadow to match ListView aesthetic
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
}
