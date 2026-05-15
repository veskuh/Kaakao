import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype KaakaoTableRowDelegate
    \inqmlmodule Kaakao
    \brief A multi-column row delegate for KaakaoTableView.

    KaakaoTableRowDelegate renders a full-width row with zebra striping and 
    dynamic cell layout based on the column definitions of the parent view.
*/
ItemDelegate {
    id: control

    // Desktop rows are compact
    implicitHeight: 24
    implicitWidth: ListView.view ? ListView.view.width : 200

    /*! \qmlproperty list<KaakaoTableColumn> KaakaoTableRowDelegate::columns
        The list of column definitions to use for layout. Usually bound to the view's columns.
    */
    property list<KaakaoTableColumn> columns

    readonly property bool isEvenRow: index % 2 === 0
    readonly property bool isSelected: ListView.isCurrentItem
    readonly property var rowData: modelData

    onClicked: {
        if (ListView.view) {
            ListView.view.currentIndex = index
            ListView.view.forceActiveFocus()
        }
    }

    background: Rectangle {
        anchors.fill: parent
        color: {
            if (control.isSelected) {
                if (control.ListView.view && control.ListView.view.activeFocus)
                    return Theme.primaryAccent;
                return Theme.isDarkMode ? "#444444" : "#DCDCDC";
            }
            if (Theme.isDarkMode)
                return control.isEvenRow ? "#252525" : "#2E2E2E";
            else
                return control.isEvenRow ? "#FFFFFF" : "#F4F5F5";
        }
    }

    contentItem: Row {
        id: cellRow
        anchors.fill: parent
        spacing: 0

        Repeater {
            model: control.columns
            delegate: Item {
                width: modelData.width
                height: control.height
                clip: true

                Label {
                    anchors.fill: parent
                    anchors.leftMargin: 8
                    anchors.rightMargin: 8
                    verticalAlignment: Text.AlignVCenter
                    text: {
                        let roleName = modelData.role
                        // Try rowData (JS model) then try model (ListModel roles available via context)
                        if (control.rowData !== undefined && control.rowData[roleName] !== undefined)
                            return control.rowData[roleName]
                        if (model[roleName] !== undefined)
                            return model[roleName]
                        return ""
                    }
                    font: Theme.defaultFont
                    elide: Text.ElideRight
                    renderType: Text.NativeRendering
                    color: (control.isSelected && control.ListView.view && control.ListView.view.activeFocus) 
                           ? "#FFFFFF" 
                           : Theme.primaryText
                }

                // Vertical divider line (optional, Finder usually doesn't show them between data cells, 
                // but we can add a very subtle one or skip it for a cleaner look)
                Rectangle {
                    anchors.right: parent.right
                    height: parent.height
                    width: 1
                    color: Theme.isDarkMode ? "#1A1A1A" : "#E0E0E0"
                    visible: index < control.columns.length - 1
                }
            }
        }
    }
}
