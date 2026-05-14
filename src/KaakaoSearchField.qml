import QtQuick
import QtQuick.Controls.Basic
import Qt5Compat.GraphicalEffects

/*!
    \qmltype KaakaoSearchField
    \inqmlmodule Kaakao
    \brief A classical macOS-style search field with a capsule shape and integrated clear button.
    \inherits QtQuick.Controls.TextField

    KaakaoSearchField implements the iconic rounded search input, featuring
    a magnifying glass indicator and a contextual clear button.
*/
TextField {
    id: control

    property bool showClearButton: true
    signal searchRequested(string query)

    implicitWidth: 200
    implicitHeight: 22
    leftPadding: 26
    rightPadding: (showClearButton && text.length > 0) ? 26 : 8
    topPadding: 2
    bottomPadding: 2
    
    font: Theme.defaultFont
    color: Theme.primaryText
    selectionColor: Theme.primaryAccent
    selectedTextColor: "white"
    placeholderTextColor: Qt.rgba(Theme.primaryText.r, Theme.primaryText.g, Theme.primaryText.b, 0.4)
    verticalAlignment: TextInput.AlignVCenter

    background: Rectangle {
        id: bg
        radius: height / 2
        color: Theme.contentBackground
        border.color: Theme.textFieldBorder
        border.width: 1

        // Inner Top Shadow (Sunken effect)
        Rectangle {
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: 1
                leftMargin: bg.radius / 2
                rightMargin: bg.radius / 2
            }
            height: 1
            color: Theme.textFieldInnerShadow
            radius: bg.radius
        }

        // Focus Ring
        KaakaoFocusRing {
            target: bg
            active: control.activeFocus
            focusRadius: bg.radius + 3
        }
    }

    // Search Icon (Magnifying Glass) - Direct child of Control to be on top
    Text {
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        text: "🔍"
        font.pixelSize: 12
        opacity: 0.5
        z: 1
    }

    // Clear Button - Direct child of Control to be on top of contentItem
    Item {
        anchors.right: parent.right
        anchors.rightMargin: 6
        anchors.verticalCenter: parent.verticalCenter
        width: 14
        height: 14
        visible: control.showClearButton && control.text.length > 0
        z: 2

        Rectangle {
            anchors.fill: parent
            radius: width / 2
            color: clearMouse.containsPress ? "#888" : "#BBB"
            opacity: 0.6

            Text {
                anchors.centerIn: parent
                text: "×"
                color: "white"
                font.pixelSize: 12
                font.bold: true
                anchors.verticalCenterOffset: -1
            }
        }

        MouseArea {
            id: clearMouse
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                control.text = ""
                control.forceActiveFocus()
            }
        }
    }

    onAccepted: searchRequested(text)
}
