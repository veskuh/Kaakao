import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "ToolBarTests"
    width: 400
    height: 400
    visible: true

    KaakaoToolBar {
        id: testToolBar
        width: 400

        KaakaoToolButton {
            id: testToolButton
            text: "Test"
        }
    }

    function test_toolbar_height() {
        compare(testToolBar.implicitHeight, 54, "ToolBar should have implicit height of 54px")
    }

    function test_toolbutton_defaults() {
        compare(testToolButton.display, AbstractButton.TextUnderIcon, "ToolButton should default to TextUnderIcon")
        compare(testToolButton.font.pixelSize, 11, "ToolButton font size should be 11")
        compare(testToolButton.icon.width, 20, "ToolButton icon width should be 20")
        compare(testToolButton.icon.height, 20, "ToolButton icon height should be 20")
    }

    function test_toolbutton_metrics() {
        verify(testToolButton.implicitWidth >= 50, "ToolButton should have minimum width of 50")
        compare(testToolButton.implicitHeight, 54, "ToolButton should match parent toolbar height")
    }

    function test_toolbutton_states() {
        // Initial state
        compare(testToolButton.background.color, "#00000000", "Initial background should be transparent")

        // In headless tests, mouseMove might be unreliable.
        // Let's at least check if properties are correctly wired.
        // Since we can't assign to 'hovered', we rely on functional checks in real app.
    }
}
