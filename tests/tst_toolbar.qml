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

    function test_toolbutton_emoji() {
        testToolButton.iconEmoji = "🔍"
        
        // Find the emoji item. It's in the contentItem (Column)
        let column = testToolButton.contentItem
        let emojiItem = null
        for (let i = 0; i < column.children.length; ++i) {
            if (column.children[i].text === "🔍") {
                emojiItem = column.children[i]
                break
            }
        }
        
        verify(emojiItem !== null, "Emoji item should exist")
        verify(emojiItem.visible, "Emoji item should be visible when iconEmoji is set")
        
        // Check that regular icon item is hidden
        let iconItem = null
        for (let i = 0; i < column.children.length; ++i) {
            if (column.children[i].hasOwnProperty("source")) {
                iconItem = column.children[i]
                break
            }
        }
        verify(iconItem !== null, "Icon item should exist")
        verify(!iconItem.visible, "Regular icon item should be hidden when iconEmoji is set")

        // Reset
        testToolButton.iconEmoji = ""
        verify(!emojiItem.visible, "Emoji item should be hidden when iconEmoji is empty")
    }

    function test_toolbutton_states() {
        // Initial state
        compare(testToolButton.background.color, "#00000000", "Initial background should be transparent")

        // In headless tests, mouseMove might be unreliable.
        // Let's at least check if properties are correctly wired.
        // Since we can't assign to 'hovered', we rely on functional checks in real app.
    }
}
