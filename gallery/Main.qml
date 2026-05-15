import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Kaakao
import Gallery

KaakaoWindow {
    id: root
    width: 900
    height: 600
    visible: true
    title: qsTr("Kaakao Component Gallery")

    header: KaakaoToolBar {
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 8
            anchors.rightMargin: 8
            spacing: 4
            
            KaakaoToolButton {
                text: "Sidebar"
                iconEmoji: "📂"
                onClicked: sidebar.collapsed = !sidebar.collapsed
            }

            Item { Layout.preferredWidth: 8 } // Spacer

            KaakaoToolButton {
                text: "Back"
                iconEmoji: "◀"
                enabled: false 
            }
            KaakaoToolButton {
                text: "Forward"
                iconEmoji: "▶"
                enabled: false 
            }
            
            Item { Layout.preferredWidth: 8 } // Spacer
            
            KaakaoToolButton {
                text: "Refresh"
                iconEmoji: "↻"
            }
            
            Item {
                Layout.fillWidth: true
            } // Flexible spacer
            
            KaakaoSearchField {
                placeholderText: "Search..."
                Layout.preferredWidth: 150
                onSearchRequested: (query) => console.log("Searching for:", query)
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

    RowLayout {
        anchors.fill: parent
        spacing: 0

        KaakaoSidebar {
            id: sidebar
            Layout.fillHeight: true
            model: ListModel {
                ListElement { name: "Components"; icon: "🧩"; category: "Library" }
                ListElement { name: "Inputs"; icon: "⌨️"; category: "Library" }
                ListElement { name: "Project"; icon: "📦"; category: "General" }
                ListElement { name: "Settings"; icon: "⚙️"; category: "General" }
            }
        }

        StackLayout {
            id: contentStack
            Layout.fillWidth: true
            Layout.fillHeight: true
            currentIndex: sidebar.currentIndex

            // 0: Components View
            ScrollView {
                id: componentsScroll
                clip: true
                contentWidth: availableWidth
                
                ColumnLayout {
                    width: componentsScroll.availableWidth
                    spacing: 0 // Using 0 spacing for precise manual offsets

                    Item { Layout.preferredHeight: 10 } // Matches Sidebar anchors.topMargin: 10

                    KaakaoLabel {
                        text: "Core Components"
                        role: KaakaoLabel.Role.Header
                        Layout.alignment: Qt.AlignHCenter
                        Layout.bottomMargin: 32 // Re-add vertical spacing below header
                    }

                    GridLayout {
                        columns: 2
                        columnSpacing: 20
                        rowSpacing: 16
                        Layout.alignment: Qt.AlignHCenter

                        KaakaoLabel { 
                            text: "Standard Button:" 
                            Layout.alignment: Qt.AlignRight
                        }
                        KaakaoButton {
                            text: "Push Me"
                            Layout.alignment: Qt.AlignLeft
                            onClicked: console.log("Standard button clicked")
                        }

                        KaakaoLabel { 
                            text: "Focused State:" 
                            Layout.alignment: Qt.AlignRight
                        }
                        KaakaoButton {
                            text: "I am Focused"
                            focus: true
                            Layout.alignment: Qt.AlignLeft
                        }

                        KaakaoLabel { 
                            text: "Segmented Control:" 
                            Layout.alignment: Qt.AlignRight
                        }
                        KaakaoSegmentedControl {
                            model: ["Grid", "List", "Tree"]
                            currentIndex: 1
                            Layout.alignment: Qt.AlignLeft
                        }

                        KaakaoLabel { 
                            text: "Slider Control:" 
                            Layout.alignment: Qt.AlignRight
                        }
                        KaakaoSlider {
                            value: 0.5
                            Layout.alignment: Qt.AlignLeft
                        }

                        KaakaoLabel { 
                            text: "Progress Bar:" 
                            Layout.alignment: Qt.AlignRight
                        }
                        KaakaoProgressBar {
                            id: galleryProgress
                            value: 0.0
                            Layout.alignment: Qt.AlignLeft
                            
                            SequentialAnimation {
                                loops: Animation.Infinite
                                running: true
                                
                                NumberAnimation {
                                    target: galleryProgress
                                    property: "value"
                                    from: 0.0
                                    to: 1.0
                                    duration: 4000
                                    easing.type: Easing.InOutQuad
                                }
                                PauseAnimation { duration: 2000 }
                                PropertyAction {
                                    target: galleryProgress
                                    property: "value"
                                    value: 0.0
                                }
                                PauseAnimation { duration: 500 } // Short pause before restarting
                            }
                        }

                        KaakaoLabel { 
                            text: "Indeterminate:" 
                            Layout.alignment: Qt.AlignRight
                        }
                        KaakaoProgressBar {
                            indeterminate: true
                            Layout.alignment: Qt.AlignLeft
                        }

                        KaakaoLabel { 
                            text: "Small Detail:" 
                            Layout.alignment: Qt.AlignRight
                        }
                        KaakaoLabel {
                            text: "This is a small label role"
                            role: KaakaoLabel.Role.Small
                            Layout.alignment: Qt.AlignLeft
                        }

                        KaakaoLabel { 
                            text: "Disclosure:" 
                            Layout.alignment: Qt.AlignRight
                        }
                        ColumnLayout {
                            spacing: 4
                            Layout.alignment: Qt.AlignLeft
                            KaakaoDisclosureTriangle {
                                id: disclosure
                                text: "Advanced Options"
                            }
                            Rectangle {
                                visible: disclosure.expanded
                                Layout.preferredWidth: 150
                                Layout.preferredHeight: 40
                                color: Theme.isDarkMode ? "#333" : "#F0F0F0"
                                radius: 4
                                border.color: Theme.buttonBorder
                                border.width: 1
                                
                                KaakaoLabel {
                                    anchors.centerIn: parent
                                    text: "Hidden Content"
                                    role: KaakaoLabel.Role.Small
                                }
                            }
                        }
                    }

                    Item { Layout.preferredHeight: 40 } // Bottom Spacer
                }
            }

            // 1: Inputs View
            ScrollView {
                id: inputsScroll
                clip: true
                contentWidth: availableWidth

                ColumnLayout {
                    width: inputsScroll.availableWidth
                    spacing: 0

                    Item { Layout.preferredHeight: 10 } // Matches Sidebar topMargin

                    KaakaoLabel {
                        text: "Form Controls"
                        role: KaakaoLabel.Role.Header
                        Layout.alignment: Qt.AlignHCenter
                        Layout.bottomMargin: 32
                    }

                    GridLayout {
                        columns: 2
                        columnSpacing: 20
                        rowSpacing: 16
                        Layout.alignment: Qt.AlignHCenter

                        KaakaoLabel { 
                            text: "Text Input:" 
                            Layout.alignment: Qt.AlignRight
                        }
                        KaakaoTextField {
                            placeholderText: "Type something..."
                            width: 150
                            Layout.alignment: Qt.AlignLeft
                        }

                        KaakaoLabel { 
                            text: "Search Input:" 
                            Layout.alignment: Qt.AlignRight
                        }
                        KaakaoSearchField {
                            placeholderText: "Search items..."
                            Layout.preferredWidth: 150
                            Layout.alignment: Qt.AlignLeft
                        }

                        KaakaoLabel { 
                            text: "Text Area:" 
                            Layout.alignment: Qt.AlignRight | Qt.AlignTop
                        }
                        KaakaoTextArea {
                            placeholderText: "Multi-line text entry..."
                            Layout.preferredWidth: 200
                            Layout.preferredHeight: 100
                            Layout.alignment: Qt.AlignLeft
                        }

                        KaakaoLabel { 
                            text: "Selection (PopUp):" 
                            Layout.alignment: Qt.AlignRight
                        }
                        KaakaoComboBox {
                            model: ["Option 1", "Option 2", "Option 3", "Option 4"]
                            Layout.alignment: Qt.AlignLeft
                        }

                        KaakaoLabel { 
                            text: "Checkboxes:" 
                            Layout.alignment: Qt.AlignRight
                        }
                        RowLayout {
                            spacing: 12
                            Layout.alignment: Qt.AlignLeft
                            KaakaoCheckBox { text: "Option A"; checked: true }
                            KaakaoCheckBox { text: "Option B" }
                        }

                        KaakaoLabel { 
                            text: "Radio Buttons:" 
                            Layout.alignment: Qt.AlignRight
                        }
                        RowLayout {
                            spacing: 12
                            Layout.alignment: Qt.AlignLeft
                            KaakaoRadioButton { text: "Choice 1"; checked: true }
                            KaakaoRadioButton { text: "Choice 2" }
                        }
                    }

                    Item { Layout.preferredHeight: 40 } // Bottom Spacer
                }
            }

            // 2: Project View
            Item {
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 16

                    KaakaoLabel {
                        text: "Project Resources"
                        role: KaakaoLabel.Role.Header
                        Layout.alignment: Qt.AlignLeft
                    }

                    KaakaoTableView {
                        id: projectList
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        
                        columns: [
                            KaakaoTableColumn { title: "Name"; role: "name"; width: 200 },
                            KaakaoTableColumn { title: "Size"; role: "size"; width: 80 },
                            KaakaoTableColumn { title: "Kind"; role: "type"; width: 120 }
                        ]

                        property var projectData: [
                            { name: "CMakeLists.txt", size: "2 KB", type: "Configuration" },
                            { name: "README.md", size: "4 KB", type: "Markdown" },
                            { name: "src/KaakaoButton.qml", size: "3 KB", type: "QML Source" },
                            { name: "src/Theme.qml", size: "5 KB", type: "QML Source" },
                            { name: "tests/tst_kaakaobutton.qml", size: "2 KB", type: "QML Test" },
                            { name: "assets/logo.png", size: "12 KB", type: "Image" },
                            { name: "docs/index.html", size: "8 KB", type: "HTML" }
                        ]

                        model: projectData

                        onSortRequested: (role, order) => {
                            console.log("Sort requested for", role, "order", order)
                            let data = projectData.slice()
                            data.sort((a, b) => {
                                let valA = a[role]
                                let valB = b[role]
                                if (valA < valB) return order === Qt.AscendingOrder ? -1 : 1
                                if (valA > valB) return order === Qt.AscendingOrder ? 1 : -1
                                return 0
                            })
                            projectData = data
                        }
                    }
                }
            }

            // 3: Settings View
            Item {
                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 32
                    
                    KaakaoLabel {
                        text: "Application Settings"
                        role: KaakaoLabel.Role.Header
                        Layout.alignment: Qt.AlignHCenter
                    }

                    ColumnLayout {
                        spacing: 12
                        Layout.alignment: Qt.AlignHCenter
                        
                        KaakaoLabel {
                            text: "Appearance"
                            Layout.alignment: Qt.AlignHCenter
                        }
                        
                        KaakaoSegmentedControl {
                            id: themeSelector
                            model: ["System", "Light", "Dark"]
                            currentIndex: Theme.themeMode
                            Layout.alignment: Qt.AlignHCenter
                            onCurrentIndexChanged: {
                                if (Theme.themeMode !== currentIndex) {
                                    Theme.themeMode = currentIndex
                                }
                            }
                        }
                    }

                    Rectangle {
                        Layout.preferredWidth: 200
                        Layout.preferredHeight: 1
                        color: Theme.sidebarBorder
                        opacity: 0.3
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Text {
                        text: Theme.isDarkMode ? "Dark Mode Active" : "Light Mode Active"
                        font: Theme.defaultFont
                        color: Theme.primaryText
                        opacity: 0.5
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }
        }
    }
}
