import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "ControlsTests"
    width: 400
    height: 400
    visible: true

    Column {
        spacing: 10
        KaakaoCheckBox { id: checkBox; text: "Check Box" }
        KaakaoRadioButton { id: radioButton; text: "Radio Button" }
        KaakaoSegmentedControl {
            id: segmented
            model: ["One", "Two", "Three"]
        }
        KaakaoTextArea { id: textArea; text: "Initial Text" }
        KaakaoComboBox { id: comboBox; model: ["Apple", "Banana", "Cherry"] }
    }

    function test_checkbox() {
        compare(checkBox.checked, false, "Should be unchecked initially")
        mouseClick(checkBox)
        compare(checkBox.checked, true, "Should be checked after click")
        mouseClick(checkBox)
        compare(checkBox.checked, false, "Should be unchecked after second click")
    }

    function test_radiobutton() {
        compare(radioButton.checked, false, "Should be unchecked initially")
        mouseClick(radioButton)
        compare(radioButton.checked, true, "Should be checked after click")
    }

    function test_segmented() {
        compare(segmented.currentIndex, 0, "Initial index should be 0")
        compare(segmented.model.length, 3, "Model should have 3 items")
        
        // Find the second item and click it
        segmented.currentIndex = 1
        compare(segmented.currentIndex, 1, "Index should update to 1")
    }

    function test_textarea() {
        compare(textArea.text, "Initial Text", "TextArea should have initial text")
        textArea.text = "New Text"
        compare(textArea.text, "New Text", "TextArea text should update")
    }

    function test_combobox() {
        compare(comboBox.currentIndex, 0, "Initial index should be 0")
        compare(comboBox.currentText, "Apple", "Initial text should be Apple")
        
        comboBox.currentIndex = 2
        compare(comboBox.currentIndex, 2, "Index should update to 2")
        compare(comboBox.currentText, "Cherry", "Text should update to Cherry")
    }
}
