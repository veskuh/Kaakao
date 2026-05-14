import QtQuick
import QtQuick.Window
import Kaakao

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Kaakao Component Gallery")
    color: Theme.windowBackground

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Classical macOS Aesthetic"
            font.pixelSize: 24
            color: Theme.primaryText
        }

        Row {
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter
            
            Button {
                text: "Standard Button"
                onClicked: console.log("Standard clicked")
            }

            Button {
                text: "Focused Button"
                focus: true
            }
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: Theme.isDarkMode ? "Dark Mode Active" : "Light Mode Active"
            font: Theme.defaultFont
            color: Theme.primaryText
            opacity: 0.7
        }
    }
}
