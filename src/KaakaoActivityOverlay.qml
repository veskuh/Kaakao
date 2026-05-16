import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

/*!
    \qmltype KaakaoActivityOverlay
    \inqmlmodule Kaakao
    \brief A blocking themed overlay with a busy indicator and status text.

    KaakaoActivityOverlay dims the content area and blocks mouse interactions,
    providing visual feedback that a long-running operation is in progress.
*/
Rectangle {
    id: control

    /*! \qmlproperty string KaakaoActivityOverlay::text
        The status message to display beneath the busy indicator.
    */
    property string text: "Loading..."

    /*! \qmlproperty bool KaakaoActivityOverlay::active
        True if the overlay is visible and blocking interactions.
    */
    property bool active: false

    anchors.fill: parent
    z: 1000
    visible: active
    color: Theme.isDarkMode ? Qt.rgba(0,0,0,0.5) : Qt.rgba(1,1,1,0.5)

    // Block mouse interactions
    MouseArea {
        anchors.fill: parent
        enabled: control.visible
        hoverEnabled: true
        preventStealing: true
        onClicked: (mouse) => mouse.accepted = true
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 20

        KaakaoBusyIndicator {
            Layout.alignment: Qt.AlignHCenter
            running: control.active
            implicitWidth: 48
            implicitHeight: 48
        }

        KaakaoLabel {
            Layout.alignment: Qt.AlignHCenter
            text: control.text
            role: KaakaoLabel.Role.Header
            font.pixelSize: 16
        }
    }

    Behavior on opacity { NumberAnimation { duration: 200 } }
    opacity: active ? 1.0 : 0.0
}
