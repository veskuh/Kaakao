import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype KaakaoListDelegate
    \inqmlmodule Kaakao
    \brief A standard desktop list row featuring zebra striping and selection inversion.

    KaakaoListDelegate is designed to be used as the delegate inside a KaakaoListView.
    It automatically handles alternating background colors based on its index, and 
    paints a full-width classic macOS selection band when selected.

    \qml
    import Kaakao

    KaakaoListView {
        model: ["Documents", "Downloads", "Desktop"]
        delegate: KaakaoListDelegate {
            text: modelData
        }
    }
    \endqml
*/
ItemDelegate {
    id: control

    // Desktop rows are compact for data density
    implicitHeight: 24
    implicitWidth: ListView.view ? ListView.view.width : 200

    /*!
        \qmlproperty bool KaakaoListDelegate::isEvenRow
        \readonly
        Internal helper to determine if the row index is even for zebra striping.
    */
    readonly property bool isEvenRow: index % 2 === 0

    /*!
        \qmlproperty bool KaakaoListDelegate::isSelected
        \readonly
        True if this specific delegate is the currently selected item in the View.
    */
    readonly property bool isSelected: ListView.isCurrentItem

    onClicked: {
        if (ListView.view) {
            ListView.view.currentIndex = index
            ListView.view.forceActiveFocus()
        }
    }

    // Background rendering handles zebra stripes and selection state
    background: Rectangle {
        anchors.fill: parent

        color: {
            if (control.isSelected) {
                // If the list has focus, use Aqua Blue. Otherwise, use neutral gray.
                if (control.ListView.view && control.ListView.view.activeFocus)
                    return Theme.primaryAccent;
                return Theme.isDarkMode ? "#444444" : "#DCDCDC";
            }
            
            // Zebra striping for unselected rows
            if (Theme.isDarkMode)
                return control.isEvenRow ? "#252525" : "#2E2E2E";
            else
                return control.isEvenRow ? "#FFFFFF" : "#F4F5F5";
        }
    }

    // Standard desktop layout for icon + text
    contentItem: Row {
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8
        spacing: 6

        Image {
            id: rowIcon
            anchors.verticalCenter: parent.verticalCenter
            width: 16; height: 16
            visible: status === Image.Ready
            // Note: In a production app, use a shader here to overlay white on the icon if selected!
        }

        Label {
            anchors.verticalCenter: parent.verticalCenter
            text: control.text
            font: Theme.defaultFont
            renderType: Text.NativeRendering
            // Text color logic: Invert to white if highlighted with Primary Accent
            color: (control.isSelected && control.ListView.view && control.ListView.view.activeFocus) 
                   ? "#FFFFFF" 
                   : Theme.primaryText
        }
    }
}
