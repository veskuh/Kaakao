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
                    return Theme.selectionBackgroundActive;
                return Theme.selectionBackgroundInactive;
            }
            return control.isEvenRow ? Theme.alternatingRowBackgroundEven : Theme.alternatingRowBackgroundOdd;
        }
    }

    contentItem: Row {
        id: cellRow
        anchors.fill: parent
        spacing: 0

        Repeater {
            model: control.columns
            delegate: Item {
                id: cellItem
                width: modelData.width
                height: control.height
                clip: true

                readonly property string cellValue: {
                    let roleName = modelData.role
                    if (control.rowData !== undefined && control.rowData[roleName] !== undefined)
                        return control.rowData[roleName]
                    if (model[roleName] !== undefined)
                        return model[roleName]
                    return ""
                }

                ToolTip.visible: cellMouse.containsMouse && ToolTip.text !== ""
                ToolTip.text: {
                    if (modelData.showAsIndicator) {
                        return cellItem.cellValue
                    }
                    let roleName = modelData.role
                    let tooltipRole = roleName + "Tooltip"
                    if (control.rowData !== undefined && control.rowData[tooltipRole] !== undefined)
                        return control.rowData[tooltipRole]
                    if (model[tooltipRole] !== undefined)
                        return model[tooltipRole]
                    if (cellLabel.truncated)
                        return cellLabel.text
                    return ""
                }

                MouseArea {
                    id: cellMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    acceptedButtons: Qt.NoButton
                }

                // Custom Status Indicator
                Rectangle {
                    anchors.centerIn: parent
                    width: 10
                    height: 10
                    radius: 5
                    visible: modelData.showAsIndicator
                    color: {
                        let colorRole = modelData.indicatorColorRole
                        if (colorRole && control.rowData !== undefined && control.rowData[colorRole] !== undefined) {
                            let valColor = control.rowData[colorRole]
                            if (valColor === "green") return Theme.colorSuccess || "#28a745"
                            if (valColor === "red") return Theme.colorError || "#ff3b30"
                            if (valColor === "orange") return "#ff9500"
                            if (valColor === "purple") return "#af52de"
                            return valColor
                        }
                        // Fallback to value if it's already a color string/HEX
                        let val = cellItem.cellValue
                        if (val.startsWith("#") || val === "red" || val === "green" || val === "blue" || val === "orange" || val === "yellow" || val === "gray" || val === "purple")
                            return val
                        return "gray"
                    }
                    border.width: 1
                    border.color: Theme.isDarkMode ? "rgba(255,255,255,0.2)" : "rgba(0,0,0,0.15)"
                }

                Label {
                    id: cellLabel
                    anchors.fill: parent
                    anchors.leftMargin: 8
                    anchors.rightMargin: 8
                    verticalAlignment: Text.AlignVCenter
                    visible: !modelData.showAsIndicator
                    text: cellItem.cellValue
                    font: Theme.defaultFont
                    elide: modelData.elide !== undefined ? modelData.elide : Text.ElideRight
                    renderType: Text.NativeRendering
                    color: (control.isSelected && control.ListView.view && control.ListView.view.activeFocus) 
                           ? Theme.selectionTextActive 
                           : Theme.selectionTextInactive
                }

                // Vertical divider line (optional, Finder usually doesn't show them between data cells, 
                // but we can add a very subtle one or skip it for a cleaner look)
                Rectangle {
                    anchors.right: parent.right
                    height: parent.height
                    width: 1
                    color: Theme.headerDivider
                    visible: index < control.columns.length - 1
                }
            }
        }
    }
}
