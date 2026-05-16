import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype KaakaoGridDelegate
    \inqmlmodule Kaakao
    \brief A standard desktop grid cell featuring a classic macOS selection highlight.

    KaakaoGridDelegate is designed to be used as the delegate inside a KaakaoGridView.
    It provides a padded container for content and handles selection state visuals,
    including the characteristic blue "halo" when focused.
*/
ItemDelegate {
    id: control

    implicitWidth: 100
    implicitHeight: 120

    /*! \qmlproperty bool KaakaoGridDelegate::isSelected
        \readonly
        True if this specific delegate is the currently selected item in the View.
    */
    readonly property bool isSelected: GridView.isCurrentItem

    onClicked: {
        if (GridView.view) {
            GridView.view.currentIndex = index
            GridView.view.forceActiveFocus()
        }
    }

    background: Rectangle {
        anchors.fill: parent
        anchors.margins: 4
        radius: Theme.radiusLarge
        color: {
            if (control.isSelected) {
                // If the grid has focus, use Aqua Blue. Otherwise, use neutral gray.
                if (control.GridView.view && control.GridView.view.activeFocus)
                    return Theme.primaryAccent;
                return Theme.isDarkMode ? "#444444" : "#DCDCDC";
            }
            return "transparent"
        }
    }

    contentItem: Item {
        anchors.fill: parent
        anchors.margins: 8

        // Content placeholder for users to override or use as a base
        // Typically an Image + Label Column
    }
}
