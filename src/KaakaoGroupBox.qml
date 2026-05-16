import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype KaakaoGroupBox
    \inqmlmodule Kaakao
    \brief A titled frame used to visually group related controls.
    \inherits QtQuick.Controls.GroupBox

    KaakaoGroupBox provides a classical macOS-style frame with a title
    label at the top-left, suitable for grouping settings or form fields.
*/
GroupBox {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding,
                            implicitLabelWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    spacing: 10
    padding: 12
    topPadding: 24 // Leave space for the label

    label: KaakaoLabel {
        x: control.leftPadding
        width: control.availableWidth
        text: control.title
        role: KaakaoLabel.Role.Secondary
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        y: control.topPadding - control.padding / 2
        width: parent.width
        height: parent.height - y
        radius: Theme.radiusStandard
        color: "transparent"
        border.color: Theme.buttonBorder
        border.width: 1
    }
}
