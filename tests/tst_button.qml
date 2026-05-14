import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "ButtonTests"
    width: 400
    height: 400
    visible: false

    // Statically instantiating for headless verification
    Button {
        id: testButton
        text: "Test Button"
    }

    function test_01_initialization() {
        compare(testButton.text, "Test Button", "Text should match initial value")
        compare(testButton.implicitHeight, 22, "Button should have classic macOS height")
    }

    function test_02_theme_colors() {
        verify(testButton.background !== null, "Background should exist")
        compare(testButton.contentItem.color, Theme.primaryText, "Text color should follow theme")
    }

    function test_03_state_linkage() {
        testButton.down = true
        verify(testButton.down, "Button should report being down")
        testButton.down = false
        verify(!testButton.down, "Button should report not being down")
    }
}
