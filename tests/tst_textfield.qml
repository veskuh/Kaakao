import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "TextFieldTests"
    width: 400
    height: 400
    visible: true

    KaakaoTextField {
        id: testField
        text: "Initial Text"
    }

    function test_01_initialization() {
        compare(testField.text, "Initial Text", "Text should match initial value")
        compare(testField.implicitHeight, 22, "TextField should have classic macOS height")
    }

    function test_02_focus_ring() {
        testField.forceActiveFocus()
        verify(testField.activeFocus, "TextField should have focus")
        
        // Wait for Behavior animation on opacity
        wait(100)
        
        // We can't easily reach into the background and find the FocusRing without objectNames
        // but we can at least check if the text field itself reports active focus.
    }

    function test_03_text_editing() {
        mouseClick(testField)
        testField.text = ""
        keyClick(Qt.Key_N)
        keyClick(Qt.Key_E)
        keyClick(Qt.Key_W)
        compare(testField.text, "new", "Text should update after key clicks")
    }
}
