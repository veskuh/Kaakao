import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "IndicatorTests"
    width: 400
    height: 400
    visible: true

    Column {
        spacing: 20
        KaakaoSlider { id: testSlider; value: 0.5 }
        KaakaoProgressBar { id: testProgress; value: 0.25 }
    }

    function test_slider() {
        compare(testSlider.value, 0.5, "Slider initial value should be 0.5")
        testSlider.value = 0.8
        compare(testSlider.value, 0.8, "Slider value should update to 0.8")
        
        testSlider.value = 1.5 // Above range
        compare(testSlider.value, 1.0, "Slider value should be capped at 1.0")
    }

    function test_progressbar() {
        compare(testProgress.value, 0.25, "Progress bar initial value should be 0.25")
        testProgress.value = 0.6
        compare(testProgress.value, 0.6, "Progress bar value should update to 0.6")
        
        testProgress.indeterminate = true
        compare(testProgress.indeterminate, true, "Progress bar should support indeterminate state")
        testProgress.indeterminate = false
        compare(testProgress.indeterminate, false, "Progress bar should be able to toggle back to determinate")
    }
}
