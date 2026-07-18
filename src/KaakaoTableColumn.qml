import QtQuick

/*!
    \qmltype KaakaoTableColumn
    \inqmlmodule Kaakao
    \brief Defines the properties of a column in a KaakaoTableView.

    KaakaoTableColumn is used within the columns list of a KaakaoTableView to
    configure headers, widths, and data binding.
*/
QtObject {
    id: column

    /*! \qmlproperty string KaakaoTableColumn::title
        The text displayed in the header cell.
    */
    property string title: ""

    /*! \qmlproperty string KaakaoTableColumn::role
        The model role name used to retrieve data for this column.
    */
    property string role: ""

    /*! \qmlproperty real KaakaoTableColumn::width
        The current width of the column. This property is updated during resizing.
    */
    property real width: 100

    /*! \qmlproperty real KaakaoTableColumn::minWidth
        The minimum allowed width during resizing. Defaults to 40.
    */
    property real minWidth: 40

    /*! \qmlproperty bool KaakaoTableColumn::sortable
        Whether the column can be clicked to request sorting.
    */
    property bool sortable: true

    /*! \qmlproperty int KaakaoTableColumn::elide
        The text elide mode: Text.ElideNone, Text.ElideLeft, Text.ElideMiddle, Text.ElideRight.
    */
    property int elide: Text.ElideRight

    /*! \qmlproperty bool KaakaoTableColumn::showAsIndicator
        Whether the column cells should be displayed as a colored status dot instead of text.
    */
    property bool showAsIndicator: false

    /*! \qmlproperty string KaakaoTableColumn::indicatorColorRole
        The model role name used to retrieve the indicator's color (e.g. "green", "red", HEX).
    */
    property string indicatorColorRole: ""

    /*! \qmlproperty int KaakaoTableColumn::sortOrder
        The current sort order: Qt.AscendingOrder, Qt.DescendingOrder, or -1 for none.
    */
    property int sortOrder: -1 // -1 for none, Qt.AscendingOrder, Qt.DescendingOrder

    /*! \qmlproperty int KaakaoTableColumn::defaultSortOrder
        The default sort order when the column is first clicked: Qt.AscendingOrder or Qt.DescendingOrder. Defaults to Qt.AscendingOrder.
    */
    property int defaultSortOrder: Qt.AscendingOrder

    /*! \qmlproperty bool KaakaoTableColumn::isSorted
        True if this column is the one currently determining the sort order.
    */
    readonly property bool isSorted: sortOrder !== -1
}
