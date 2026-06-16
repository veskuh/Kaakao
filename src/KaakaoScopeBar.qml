import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtQml

/*!
    \qmltype KaakaoScopeBar
    \inqmlmodule Kaakao
    \brief A classical macOS-style scope bar used below toolbars for filtering content.
    \inherits QtQuick.Controls.Control

    KaakaoScopeBar features a compact horizontal layout containing a text label
    and a group of flat, selectable filter buttons.
*/
Control {
    id: control

    property string label: ""
    property var model: []
    property int currentIndex: 0

    signal filterSelected(int index, string name)

    implicitWidth: 400
    implicitHeight: 24

    // State properties for overflow
    property var overflowItems: []
    property bool hasOverflow: false

    readonly property bool isSelectedInOverflow: {
        for (var i = 0; i < overflowItems.length; ++i) {
            if (overflowItems[i].index === control.currentIndex) {
                return true
            }
        }
        return false
    }

    function updateLayout() {
        if (!buttonsRepeater || buttonsRepeater.count === 0) return

        var labelWidth = scopeLabel.visible ? scopeLabel.implicitWidth + 8 : 0
        var availableWidth = control.width - labelWidth - 16 // margins/paddings
        var runningWidth = 0
        var overflowList = []

        // 1. Calculate total width needed
        var totalNeeded = 0
        for (var i = 0; i < buttonsRepeater.count; ++i) {
            var btn = buttonsRepeater.itemAt(i)
            if (btn) {
                totalNeeded += btn.implicitWidth + 4 // spacing is 4
            }
        }

        // If everything fits, show all and hide moreButton
        if (totalNeeded <= availableWidth) {
            for (var i = 0; i < buttonsRepeater.count; ++i) {
                var btn = buttonsRepeater.itemAt(i)
                if (btn) btn.visible = true
            }
            control.hasOverflow = false
            control.overflowItems = []
            return
        }

        // Otherwise, reserve space for the overflow button (30px)
        availableWidth -= (moreButton.implicitWidth + 4)
        var currentlyOverflowing = false

        for (var i = 0; i < buttonsRepeater.count; ++i) {
            var btn = buttonsRepeater.itemAt(i)
            if (!btn) continue

            if (!currentlyOverflowing && (runningWidth + btn.implicitWidth <= availableWidth)) {
                btn.visible = true
                runningWidth += btn.implicitWidth + 4
            } else {
                btn.visible = false
                currentlyOverflowing = true
                overflowList.push({ index: i, text: btn.itemText })
            }
        }

        control.overflowItems = overflowList
        control.hasOverflow = currentlyOverflowing
    }

    onWidthChanged: updateLayout()
    onModelChanged: updateLayout()

    background: Rectangle {
        color: Theme.isDarkMode ? "#262626" : "#E1E1E1"
        
        // 1px solid bottom border
        Rectangle {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: 1
            color: Theme.isDarkMode ? "#121212" : "#B0B0B0"
        }
    }

    contentItem: RowLayout {
        spacing: 8
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8

        KaakaoLabel {
            id: scopeLabel
            text: control.label
            visible: control.label.length > 0
            font.weight: Font.DemiBold
            font.pixelSize: 11
            color: Theme.isDarkMode ? "#A5A5A5" : "#6E6E6E"
            Layout.alignment: Qt.AlignVCenter
        }

        Row {
            id: buttonsRow
            spacing: 4
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter

            Repeater {
                id: buttonsRepeater
                model: control.model

                delegate: Button {
                    id: scopeBtn
                    
                    // Support both list of strings and object/ListElement model
                    readonly property string itemText: typeof modelData === "string" ? modelData : (model.name || model.text || "")
                    
                    implicitHeight: 18
                    implicitWidth: contentText.implicitWidth + 12
                    padding: 0
                    
                    background: Rectangle {
                        radius: 9
                        color: {
                            if (control.currentIndex === index) {
                                return Theme.isDarkMode ? "#5A5A5A" : "#8A8A8A"
                            }
                            if (scopeBtn.pressed) {
                                return Theme.isDarkMode ? "#3A3A3A" : "#C8C8C8"
                            }
                            if (scopeBtn.hovered) {
                                return Theme.isDarkMode ? "#333333" : "#D5D5D5"
                            }
                            return "transparent"
                        }
                    }

                    contentItem: Text {
                        id: contentText
                        text: scopeBtn.itemText
                        font.family: Theme.defaultFont.family
                        font.pixelSize: 11
                        font.weight: control.currentIndex === index ? Font.Bold : Font.Normal
                        color: {
                            if (control.currentIndex === index) {
                                return "#FFFFFF"
                            }
                            return Theme.primaryText
                        }
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        renderType: Text.NativeRendering
                    }

                    onClicked: {
                        control.currentIndex = index
                        control.filterSelected(index, scopeBtn.itemText)
                    }
                }

                onCountChanged: control.updateLayout()
            }

            // More/Overflow Button
            Button {
                id: moreButton
                text: "…"
                implicitHeight: 18
                implicitWidth: 24
                visible: control.hasOverflow
                padding: 0

                background: Rectangle {
                    radius: 9
                    color: {
                        if (control.isSelectedInOverflow) {
                            return Theme.isDarkMode ? "#5A5A5A" : "#8A8A8A"
                        }
                        if (moreButton.pressed) {
                            return Theme.isDarkMode ? "#3A3A3A" : "#C8C8C8"
                        }
                        if (moreButton.hovered) {
                            return Theme.isDarkMode ? "#333333" : "#D5D5D5"
                        }
                        return "transparent"
                    }
                }

                contentItem: Text {
                    text: moreButton.text
                    font.family: Theme.defaultFont.family
                    font.pixelSize: 11
                    font.weight: Font.Bold
                    color: control.isSelectedInOverflow ? "#FFFFFF" : Theme.primaryText
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    renderType: Text.NativeRendering
                }

                onClicked: overflowMenu.popup(moreButton, 0, moreButton.height + 2)
            }
        }
    }

    KaakaoMenu {
        id: overflowMenu
        
        Instantiator {
            model: control.overflowItems
            
            delegate: KaakaoMenuItem {
                text: modelData.text
                checkable: true
                checked: control.currentIndex === modelData.index
                onTriggered: {
                    control.currentIndex = modelData.index
                    control.filterSelected(modelData.index, modelData.text)
                }
            }
            
            onObjectAdded: (index, object) => overflowMenu.insertItem(index, object)
            onObjectRemoved: (index, object) => overflowMenu.removeItem(object)
        }
    }
}
