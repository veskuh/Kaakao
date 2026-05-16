import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "SmallComponentsTests"
    width: 400
    height: 400
    visible: true

    Component {
        id: separatorComp
        KaakaoSeparator {}
    }

    Component {
        id: badgeComp
        KaakaoBadge {}
    }

    Component {
        id: busyComp
        KaakaoBusyIndicator {}
    }

    Component {
        id: groupBoxComp
        KaakaoGroupBox {}
    }

    function test_separator() {
        let obj = createTemporaryObject(separatorComp, null, { orientation: Qt.Vertical })
        verify(obj, "Separator created")
        compare(obj.orientation, Qt.Vertical)
        compare(obj.implicitWidth, 2)
        
        obj.orientation = Qt.Horizontal
        compare(obj.implicitHeight, 2)
    }

    function test_badge() {
        let obj = createTemporaryObject(badgeComp, null, { text: "123", highlighted: true })
        verify(obj, "Badge created")
        compare(obj.text, "123")
        compare(obj.highlighted, true)
    }

    function test_busyIndicator() {
        let obj = createTemporaryObject(busyComp, null, { running: true })
        verify(obj, "BusyIndicator created")
        compare(obj.running, true)
        compare(obj.implicitWidth, 16)
        compare(obj.implicitHeight, 16)
        
        obj.running = false
        compare(obj.running, false)
    }

    function test_groupBox() {
        let obj = createTemporaryObject(groupBoxComp, null, { title: "Test Group" })
        verify(obj, "GroupBox created")
        compare(obj.title, "Test Group")
    }
}
