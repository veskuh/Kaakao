import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

/*!
    \qmltype KaakaoPathControl
    \inqmlmodule Kaakao
    \brief A breadcrumb-style navigation control for hierarchical paths.

    KaakaoPathControl parses a path string and displays clickable segments
    separated by standard macOS-style chevrons.
*/
RowLayout {
    id: control

    /*! \qmlproperty string KaakaoPathControl::path
        The hierarchical path to display (e.g., "Documents/Projects/Blog").
    */
    property string path: ""

    /*! \qmlproperty string KaakaoPathControl::rootLabel
        The label for the root segment. Defaults to "Root".
    */
    property string rootLabel: "Home"

    /*! \qmlsignal KaakaoPathControl::pathClicked(string targetPath)
        Emitted when a breadcrumb segment is clicked.
    */
    signal pathClicked(string targetPath)

    spacing: 4

    Repeater {
        id: pathRepeater
        model: {
            var parts = control.path.split('/').filter(p => p.length > 0);
            var result = [{ label: control.rootLabel, path: "" }];
            var current = "";
            for (var i = 0; i < parts.length; i++) {
                current += (current === "" ? "" : "/") + parts[i];
                result.push({ label: parts[i], path: current });
            }
            return result;
        }

        delegate: Row {
            spacing: 4
            
            // Separator (except for the first item)
            KaakaoLabel {
                text: "›"
                visible: index > 0
                role: KaakaoLabel.Role.Secondary
                font.pixelSize: 16
                anchors.verticalCenter: parent.verticalCenter
            }

            KaakaoLabel {
                text: modelData.label
                role: index === pathRepeater.count - 1 ? KaakaoLabel.Role.Header : KaakaoLabel.Role.Secondary
                font.weight: index === pathRepeater.count - 1 ? Font.Bold : Font.Normal
                anchors.verticalCenter: parent.verticalCenter
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    enabled: index < pathRepeater.count - 1
                    onClicked: control.pathClicked(modelData.path)
                }
            }
        }
    }

    Item { Layout.fillWidth: true }
}
