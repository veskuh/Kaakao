import QtQuick

/*!
    \qmltype KaakaoFocusRing
    \inqmlmodule Kaakao
    \brief A reusable focus indicator ring.
    \inherits QtQuick.Rectangle

    KaakaoFocusRing provides a semi-transparent 3px primary focus ring.
    that can be applied to any component. It automatically animates its
    opacity based on the focus state of its target.
*/
Rectangle {
    id: root

    /*! \qmlproperty Item KaakaoFocusRing::target
        The item that this focus ring should follow. Defaults to the parent.
    */
    property Item target: parent

    /*! \qmlproperty bool KaakaoFocusRing::active
        Whether the focus ring is currently visible. Defaults to \c target.activeFocus.
    */
    property bool active: target ? target.activeFocus : false

    /*! \qmlproperty real KaakaoFocusRing::focusRadius
        The corner radius of the focus ring.
    */
    property real focusRadius: Theme.radiusStandard + 3

    /*! \qmlproperty real KaakaoFocusRing::ringWidth
        The width of the focus ring border. Defaults to 3.
    */
    property real ringWidth: 3

    /*! \qmlproperty real KaakaoFocusRing::ringMargin
        The margin between the focus ring and its target. Defaults to -3.
    */
    property real ringMargin: -3
    anchors.fill: target
    anchors.margins: ringMargin
    radius: focusRadius
    border.color: Theme.primaryAccent
    border.width: ringWidth
    opacity: active ? 0.4 : 0.0
    color: "transparent"

    Behavior on opacity {
        NumberAnimation { duration: 80 }
    }
}
