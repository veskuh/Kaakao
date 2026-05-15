import QtQuick
import QtQuick.Layouts
import Kaakao

KaakaoWindow {
    id: aboutWindow
    
    // Classic macOS About boxes are small and non-resizable
    width: 320
    height: 380
    minimumWidth: width
    maximumWidth: width
    minimumHeight: height
    maximumHeight: height
    
    title: qsTr("About")
    
    // Properties for customization
    property string appName: "Application"
    property string version: "1.0"
    property string copyright: "© 2026"
    property string description: "Description goes here."
    property url iconSource: ""

    Column {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 16

        // Placeholder for App Icon
        Rectangle {
            width: 64
            height: 64
            radius: 12
            color: Theme.primaryAccent
            anchors.horizontalCenter: parent.horizontalCenter
            visible: aboutWindow.iconSource == ""
            
            KaakaoLabel {
                anchors.centerIn: parent
                text: "K"
                color: "white"
                font.pixelSize: 32
                role: KaakaoLabel.Role.Header
            }
        }
        
        Image {
            source: aboutWindow.iconSource
            width: 64
            height: 64
            anchors.horizontalCenter: parent.horizontalCenter
            visible: aboutWindow.iconSource != ""
        }

        Column {
            width: parent.width
            spacing: 4
            
            KaakaoLabel {
                text: aboutWindow.appName
                role: KaakaoLabel.Role.Header
                anchors.horizontalCenter: parent.horizontalCenter
            }

            KaakaoLabel {
                text: qsTr("Version ") + aboutWindow.version
                role: KaakaoLabel.Role.Secondary
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        KaakaoLabel {
            text: aboutWindow.description
            width: parent.width
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
        }

        Item { Layout.fillHeight: true; width: 1 } // Spacer

        KaakaoLabel {
            text: aboutWindow.copyright
            role: KaakaoLabel.Role.Small
            anchors.horizontalCenter: parent.horizontalCenter
        }

        KaakaoButton {
            text: qsTr("Close")
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: aboutWindow.close()
        }
    }
}
