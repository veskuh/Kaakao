import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

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
            text: control.label
            visible: control.label.length > 0
            font.weight: Font.DemiBold
            font.pixelSize: 11
            color: Theme.isDarkMode ? "#A5A5A5" : "#6E6E6E"
            Layout.alignment: Qt.AlignVCenter
        }

        Row {
            spacing: 4
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter

            Repeater {
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
            }
        }
    }
}
