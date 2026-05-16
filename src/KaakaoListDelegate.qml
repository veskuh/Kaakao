import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype KaakaoListDelegate
    \inqmlmodule Kaakao
    \brief A standard desktop list row featuring zebra striping and selection inversion.

    KaakaoListDelegate is designed to be used as the delegate inside a KaakaoListView.
    It automatically handles alternating background colors based on its index, and 
    paints a full-width classic macOS selection band when selected.

    \qml
    import Kaakao

    KaakaoListView {
        model: ["Documents", "Downloads", "Desktop"]
        delegate: KaakaoListDelegate {
            text: modelData
        }
    }
    \endqml
*/
ItemDelegate {
    id: control

    // Desktop rows are compact for data density
    implicitHeight: subtitle.length > 0 ? 36 : 24
    implicitWidth: ListView.view ? ListView.view.width : 200

    /*! \qmlproperty string KaakaoListDelegate::subtitle
        Secondary text displayed below the main title.
    */
    property string subtitle: ""

    /*! \qmlproperty string KaakaoListDelegate::secondaryText
        Text displayed on the right side of the delegate (e.g., file size).
    */
    property string secondaryText: ""

    /*!
        \qmlproperty bool KaakaoListDelegate::isEvenRow
        \readonly
        Internal helper to determine if the row index is even for zebra striping.
    */
    readonly property bool isEvenRow: index % 2 === 0

    /*!
        \qmlproperty bool KaakaoListDelegate::isSelected
        \readonly
        True if this specific delegate is the currently selected item in the View.
    */
    readonly property bool isSelected: ListView.isCurrentItem

    onClicked: {
        if (ListView.view) {
            ListView.view.currentIndex = index
            ListView.view.forceActiveFocus()
        }
    }

    // Background rendering handles zebra stripes and selection state
    background: Rectangle {
        anchors.fill: parent

        color: {
            if (control.isSelected) {
                // If the list has focus, use Aqua Blue. Otherwise, use neutral gray.
                if (control.ListView.view && control.ListView.view.activeFocus)
                    return Theme.primaryAccent;
                return Theme.isDarkMode ? "#444444" : "#DCDCDC";
            }
            
            // Zebra striping for unselected rows
            if (Theme.isDarkMode)
                return control.isEvenRow ? "#252525" : "#2E2E2E";
            else
                return control.isEvenRow ? "#FFFFFF" : "#F4F5F5";
        }
    }

    // Standard desktop layout for icon + text
    contentItem: Row {
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8
        spacing: 10

        Image {
            id: rowIcon
            anchors.verticalCenter: parent.verticalCenter
            width: 16; height: 16
            visible: status === Image.Ready
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - (rowIcon.visible ? 26 : 0) - (rightText.visible ? rightText.width + 10 : 0)

            Label {
                objectName: "titleLabel"
                width: parent.width
                text: control.text
                font: Theme.defaultFont
                renderType: Text.NativeRendering
                elide: Text.ElideRight
                color: (control.isSelected && control.ListView.view && control.ListView.view.activeFocus) 
                       ? "#FFFFFF" 
                       : Theme.primaryText
            }

            Label {
                objectName: "subtitleLabel"
                width: parent.width
                text: control.subtitle
                visible: text.length > 0
                font.pixelSize: 11
                font.family: Theme.defaultFont.family
                renderType: Text.NativeRendering
                elide: Text.ElideRight
                color: (control.isSelected && control.ListView.view && control.ListView.view.activeFocus) 
                       ? Qt.rgba(1,1,1,0.7) 
                       : Qt.rgba(Theme.primaryText.r, Theme.primaryText.g, Theme.primaryText.b, 0.6)
            }
        }

        Label {
            id: rightText
            objectName: "secondaryLabel"
            anchors.verticalCenter: parent.verticalCenter
            text: control.secondaryText
            visible: text.length > 0
            font.pixelSize: 11
            font.family: Theme.defaultFont.family
            renderType: Text.NativeRendering
            color: (control.isSelected && control.ListView.view && control.ListView.view.activeFocus) 
                   ? Qt.rgba(1,1,1,0.7) 
                   : Qt.rgba(Theme.primaryText.r, Theme.primaryText.g, Theme.primaryText.b, 0.6)
        }
    }
}
