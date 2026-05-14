import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

/*!
    \qmltype KaakaoSidebar
    \inqmlmodule Kaakao
    \brief A classical macOS-style navigation sidebar.
    \inherits QtQuick.Rectangle

    KaakaoSidebar provides a vertical navigation container with a categorized list.
    It features the characteristic blueish-grey background from the Yosemite-Catalina era.

    \qml
    KaakaoSidebar {
        model: ListModel {
            ListElement { name: "Dashboard"; icon: "🏠"; category: "General" }
            ListElement { name: "Files"; icon: "📁"; category: "General" }
            ListElement { name: "Settings"; icon: "⚙️"; category: "System" }
        }
    }
    \endqml
*/
Rectangle {
    id: control

    property alias model: listView.model
    property alias currentIndex: listView.currentIndex
    property bool collapsed: false
    property real sidebarWidth: 200

    implicitWidth: collapsed ? 0 : sidebarWidth
    Behavior on implicitWidth { NumberAnimation { duration: 250; easing.type: Easing.InOutQuad } }

    clip: true
    color: Theme.sidebarBackground

    Rectangle {
        anchors.right: parent.right
        width: 1
        height: parent.height
        color: Theme.sidebarBorder
    }

    ListView {
        id: listView
        anchors.fill: parent
        anchors.topMargin: 10
        boundsBehavior: Flickable.StopAtBounds
        
        delegate: ItemDelegate {
            id: delegate
            width: listView.width
            height: 30
            padding: 0
            
            contentItem: RowLayout {
                spacing: 8
                Item { 
                    Layout.preferredWidth: 8 
                    Layout.alignment: Qt.AlignVCenter
                }
                
                Text {
                    text: model.icon || ""
                    font.pixelSize: 14
                    visible: text !== ""
                    Layout.alignment: Qt.AlignVCenter
                    verticalAlignment: Text.AlignVCenter
                }
                
                Text {
                    text: model.name
                    font: Theme.defaultFont
                    color: listView.currentIndex === index ? "#FFFFFF" : Theme.primaryText
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignVCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            
            background: Rectangle {
                anchors {
                    fill: parent
                    leftMargin: 6
                    rightMargin: 6
                }
                radius: 4
                color: {
                    if (listView.currentIndex === index) return Theme.primaryAccent
                    if (delegate.hovered) return Theme.toolButtonHovered
                    return "transparent"
                }
            }
            
            onClicked: listView.currentIndex = index
        }
        
        section.property: "category"
        section.delegate: Item {
            width: listView.width
            height: 30
            
            Text {
                anchors {
                    left: parent.left
                    leftMargin: 16
                    verticalCenter: parent.verticalCenter
                }
                text: section.toUpperCase()
                font.pixelSize: 11
                font.weight: Font.DemiBold
                color: Theme.sidebarSectionText
            }
        }
    }
}
