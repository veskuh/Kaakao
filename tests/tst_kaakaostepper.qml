import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "KaakaoStepperTests"
    width: 400
    height: 400
    visible: false

    Component {
        id: stepperComponent
        KaakaoStepper {
            from: 0
            to: 10
            value: 5
            stepSize: 1
        }
    }

    function test_01_initialization() {
        let stepper = createTemporaryObject(stepperComponent, this)
        verify(stepper !== null, "Stepper should be created")
        compare(stepper.from, 0, "From should be 0")
        compare(stepper.to, 10, "To should be 10")
        compare(stepper.value, 5, "Initial value should be 5")
        compare(stepper.implicitHeight, 22, "Stepper should have standard macOS height")
    }

    function test_02_increment_decrement() {
        let stepper = createTemporaryObject(stepperComponent, this)
        
        // Test programmatical increment/decrement
        stepper.increase()
        compare(stepper.value, 6, "Value should increase to 6")
        
        stepper.decrease()
        compare(stepper.value, 5, "Value should decrease back to 5")
    }

    function test_03_clamping_limits() {
        let stepper = createTemporaryObject(stepperComponent, this)
        
        // Go above upper limit
        stepper.value = 15
        compare(stepper.value, 10, "Value should be clamped to 'to' limit (10)")

        // Go below lower limit
        stepper.value = -5
        compare(stepper.value, 0, "Value should be clamped to 'from' limit (0)")
    }

    function test_04_editing() {
        let stepper = createTemporaryObject(stepperComponent, this)
        stepper.focus = true
        
        // Locate the TextInput item
        let textInput = null
        for (let i = 0; i < stepper.children.length; ++i) {
            if (stepper.children[i].text !== undefined && stepper.children[i].selectAll !== undefined) {
                textInput = stepper.children[i]
                break
            }
        }
        
        verify(textInput !== null, "TextInput child should exist")
        compare(textInput.text, "5", "TextInput should show current value")
        
        // Change text and simulate editing finished
        textInput.text = "8"
        textInput.editingFinished()
        compare(stepper.value, 8, "Value should update to 8 after editing finished")
    }

    function test_05_visual_structure() {
        let stepper = createTemporaryObject(stepperComponent, this)
        verify(stepper.background !== null, "Background should exist")
        verify(stepper.up.indicator !== null, "Up indicator should exist")
        verify(stepper.down.indicator !== null, "Down indicator should exist")
    }
}
