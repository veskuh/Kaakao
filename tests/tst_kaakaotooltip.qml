import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "ToolTipTests"
    width: 400
    height: 400
    visible: false

    KaakaoToolTip {
        id: testToolTip
        text: "Test ToolTip Text"
    }

    function test_01_initialization() {
        compare(testToolTip.text, "Test ToolTip Text", "Tooltip text should match initialization value")
        compare(testToolTip.delay, 500, "Tooltip delay should default to 500ms")
        compare(testToolTip.timeout, 5000, "Tooltip timeout should default to 5000ms")
    }

    function test_02_visibility() {
        verify(!testToolTip.opened, "Tooltip should not be opened initially")
        testToolTip.delay = 0
        testToolTip.open()
        verify(testToolTip.opened, "Tooltip should be opened when open() is called")
        testToolTip.close()
        verify(!testToolTip.opened, "Tooltip should be closed when close() is called")
    }
}
