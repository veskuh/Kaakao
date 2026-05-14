import QtQuick
import Kaakao

KaakaoWindow {
    width: 640
    height: 480
    title: qsTr("Kaakao Component Gallery")

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
