import QtQuick

/*!
    \qmltype KaakaoBadge
    \inqmlmodule Kaakao
    \brief A compact, pill-shaped indicator for counts or status labels.

    KaakaoBadge is commonly used in sidebars or list delegates to display
    numeric counts (e.g., unread messages).
*/
Rectangle {
    id: control

    /*! \qmlproperty string KaakaoBadge::text
        The text to display inside the badge.
    */
    property alias text: label.text

    /*! \qmlproperty bool KaakaoBadge::highlighted
        If true, the badge uses the primary accent color. Otherwise, it uses a neutral grey.
    */
    property bool highlighted: false

    implicitWidth: Math.max(height, label.contentWidth + 12)
    implicitHeight: 18
    radius: height / 2

    color: highlighted ? Theme.badgeHighlight : Theme.badgeBackground

    Text {
        id: label
        anchors.centerIn: parent
        color: Theme.badgeText
        font.pixelSize: 11
        font.weight: Font.Medium
        font.family: Theme.defaultFont.family
    }
}
