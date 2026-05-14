import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Kaakao
import Gallery

KaakaoWindow {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Kaakao Component Gallery")

    header: KaakaoToolBar {
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 8
            anchors.rightMargin: 8
            spacing: 4
            
            KaakaoToolButton {
                text: "Back"
                icon.name: "go-previous"
            }
            KaakaoToolButton {
                text: "Forward"
                icon.name: "go-next"
            }
            
            Item { Layout.preferredWidth: 8 } // Spacer
            
            KaakaoToolButton {
                text: "Refresh"
                icon.name: "view-refresh"
            }
            
            Item {
                Layout.fillWidth: true
            } // Flexible spacer
            
            KaakaoToolButton {
                text: "Search"
                icon.name: "edit-find"
            }
        }
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("Help")
            MenuItem {
                text: qsTr("About Kaakao...")
                onTriggered: aboutWindow.show()
            }
        }
    }

    AboutWindow {
        id: aboutWindow
        appName: "Kaakao Gallery"
        version: "0.1.0"
        description: "A Classical macOS aesthetic library for modern Qt Quick applications. Designed to feel tangible and refined."
        copyright: "© 2026 Kaakao Contributors"
    }

    Column {
        anchors.centerIn: parent
        spacing: 24

        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 8
            
            KaakaoLabel {
                text: "Kaakao Component Gallery"
                role: KaakaoLabel.Role.Header
                anchors.horizontalCenter: parent.horizontalCenter
            }

            KaakaoLabel {
                text: "Classical macOS (Yosemite-Catalina) Aesthetic"
                role: KaakaoLabel.Role.Secondary
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Grid {
            columns: 2
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            verticalItemAlignment: Grid.AlignVCenter

            KaakaoLabel { text: "Standard Button:" }
            Button {
                text: "Push Me"
                onClicked: console.log("Standard button clicked")
            }

            KaakaoLabel { text: "Focused State:" }
            Button {
                text: "I am Focused"
                focus: true
            }

            KaakaoLabel { text: "Text Input:" }
            KaakaoTextField {
                placeholderText: "Type something..."
                width: 150
            }

            KaakaoLabel { text: "Choice Controls:" }
            Row {
                spacing: 12
                KaakaoCheckBox { text: "Option A"; checked: true }
                KaakaoCheckBox { text: "Option B" }
            }

            KaakaoLabel { text: "Radio Group:" }
            Row {
                spacing: 12
                KaakaoRadioButton { text: "Choice 1"; checked: true }
                KaakaoRadioButton { text: "Choice 2" }
            }

            KaakaoLabel { text: "Segmented:" }
            KaakaoSegmentedControl {
                model: ["Grid", "List", "Tree"]
                currentIndex: 1
            }

            KaakaoLabel { text: "Small Detail:" }
            KaakaoLabel {
                text: "This is a small label role"
                role: KaakaoLabel.Role.Small
            }
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: Theme.isDarkMode ? "Dark Mode Active" : "Light Mode Active"
            font: Theme.defaultFont
            color: Theme.primaryText
            opacity: 0.5
        }
    }
}
