import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype KaakaoTableView
    \inqmlmodule Kaakao
    \brief A multi-column desktop-optimized table view.

    KaakaoTableView provides a classic macOS-style table with resizable headers,
    sorting support, zebra striping, and full-row selection.
*/
Item {
    id: control

    /*! \qmlproperty list<KaakaoTableColumn> KaakaoTableView::columns
        The list of column definitions for the table.
    */
    property list<KaakaoTableColumn> columns

    /*! \qmlproperty var KaakaoTableView::model
        The data model for the table.
    */
    property alias model: listView.model

    /*! \qmlproperty int KaakaoTableView::currentIndex
        The index of the currently selected row.
    */
    property alias currentIndex: listView.currentIndex

    /*! \qmlsignal KaakaoTableView::sortRequested(string role, int order)
        Emitted when a column header is clicked to request sorting.
    */
    signal sortRequested(string role, int order)

    implicitWidth: 400
    implicitHeight: 300

    // Enforce an outer structural frame (Sunken well aesthetic)
    Rectangle {
        anchors.fill: parent
        color: Theme.contentBackground
        border.color: Theme.textFieldBorder
        border.width: 1
        z: -1
    }

    Column {
        anchors.fill: parent
        anchors.margins: 1
        spacing: 0

        // Table Header
        Rectangle {
            id: headerArea
            width: parent.width
            height: 22
            z: 2
            
            gradient: Gradient {
                GradientStop { position: 0.0; color: Theme.isDarkMode ? "#454545" : "#F6F6F6" }
                GradientStop { position: 1.0; color: Theme.isDarkMode ? "#3C3C3C" : "#E8E8E8" }
            }

            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: Theme.isDarkMode ? "#121212" : "#B0B0B0"
            }

            Row {
                id: headerRow
                objectName: "headerRow"
                anchors.fill: parent
                spacing: 0

                Repeater {
                    model: control.columns
                    delegate: Item {
                        width: modelData.width
                        height: headerArea.height
                        z: columns.length - index // Ensure earlier columns (and their resize handles) are on top of later ones

                        MouseArea {
                            objectName: "headerClickArea_" + index
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                if (modelData.sortable) {
                                    let newOrder = modelData.sortOrder === Qt.AscendingOrder ? Qt.DescendingOrder : Qt.AscendingOrder
                                    // Reset other columns
                                    for (let i = 0; i < control.columns.length; ++i) {
                                        if (control.columns[i] !== modelData)
                                            control.columns[i].sortOrder = -1
                                    }
                                    modelData.sortOrder = newOrder
                                    control.sortRequested(modelData.role, newOrder)
                                }
                            }
                        }

                        Label {
                            anchors.fill: parent
                            anchors.leftMargin: 8
                            anchors.rightMargin: 16
                            text: modelData.title
                            font.pixelSize: 11
                            font.weight: modelData.isSorted ? Font.Bold : Font.Normal
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                            color: Theme.primaryText
                        }

                        // Sort Indicator
                        Text {
                            anchors.right: parent.right
                            anchors.rightMargin: 6
                            anchors.verticalCenter: parent.verticalCenter
                            visible: modelData.isSorted
                            text: modelData.sortOrder === Qt.AscendingOrder ? "▴" : "▾"
                            font.pixelSize: 10
                            color: Theme.primaryText
                        }

                        // Vertical Divider
                        Rectangle {
                            anchors.right: parent.right
                            height: parent.height
                            width: 1
                            color: Theme.isDarkMode ? "#2A2A2A" : "#C4C4C4"
                        }

                        // Resize Handle
                        MouseArea {
                            objectName: "resizeHandle_" + index
                            anchors.right: parent.right
                            anchors.rightMargin: -4
                            width: 8
                            height: parent.height
                            cursorShape: Qt.SizeHorCursor
                            
                            property real startX
                            property real startWidth

                            onPressed: (mouse) => {
                                let scenePos = mapToItem(headerRow, mouse.x, mouse.y)
                                startX = scenePos.x
                                startWidth = control.columns[index].width
                            }

                            onPositionChanged: (mouse) => {
                                if (pressed) {
                                    let scenePos = mapToItem(headerRow, mouse.x, mouse.y)
                                    let diff = scenePos.x - startX
                                    control.columns[index].width = Math.max(control.columns[index].minWidth, startWidth + diff)
                                }
                            }
                        }
                    }
                }
            }
        }

        // Table Body
        ListView {
            id: listView
            width: parent.width
            height: parent.height - headerArea.height
            clip: true
            focus: true
            interactive: false
            boundsBehavior: Flickable.StopAtBounds
            keyNavigationEnabled: true
            highlightMoveDuration: 0

            delegate: KaakaoTableRowDelegate {
                columns: control.columns
            }

            // Inner top shadow
            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: 3
                z: 1
                gradient: Gradient {
                    GradientStop { position: 0.0; color: Theme.isDarkMode ? "#33000000" : "#1A000000" }
                    GradientStop { position: 1.0; color: "transparent" }
                }
            }
        }
    }
}
