import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "ControlButtonTests"
    width: 400
    height: 400
    visible: true

    Component {
        id: buttonComp
        KaakaoControlButton {}
    }

    function test_default_properties() {
        let btn = createTemporaryObject(buttonComp, null)
        verify(btn, "ControlButton created successfully")
        compare(btn.controlStyle, KaakaoControlButton.ControlStyle.Inline, "Default style should be Inline")
        compare(btn.controlType, KaakaoControlButton.ControlType.Close, "Default type should be Close")
        compare(btn.active, true, "Default active should be true")
        compare(btn.groupHovered, false, "Default groupHovered should be false")
        compare(btn.implicitWidth, 14, "Default implicitWidth should be 14")
        compare(btn.implicitHeight, 14, "Default implicitHeight should be 14")
    }

    function test_style_and_type_changes() {
        let btn = createTemporaryObject(buttonComp, null)
        verify(btn, "ControlButton created successfully")
        
        btn.controlStyle = KaakaoControlButton.ControlStyle.Window
        compare(btn.controlStyle, KaakaoControlButton.ControlStyle.Window, "Style should change to Window")

        btn.controlType = KaakaoControlButton.ControlType.Minimize
        compare(btn.controlType, KaakaoControlButton.ControlType.Minimize, "Type should change to Minimize")

        btn.controlType = KaakaoControlButton.ControlType.Zoom
        compare(btn.controlType, KaakaoControlButton.ControlType.Zoom, "Type should change to Zoom")

        btn.controlStyle = KaakaoControlButton.ControlStyle.Help
        compare(btn.controlStyle, KaakaoControlButton.ControlStyle.Help, "Style should change to Help")
    }

    function test_active_state() {
        let btn = createTemporaryObject(buttonComp, null, { controlStyle: KaakaoControlButton.ControlStyle.Window })
        compare(btn.active, true, "Should be active by default")
        
        btn.active = false
        compare(btn.active, false, "Should support inactive state")
    }

    function test_new_styles() {
        let btn = createTemporaryObject(buttonComp, null)
        verify(btn, "ControlButton created successfully")

        // Add Style
        btn.controlStyle = KaakaoControlButton.ControlStyle.Add
        compare(btn.controlStyle, KaakaoControlButton.ControlStyle.Add, "Style should be Add")
        compare(btn.implicitWidth, 16, "Add style implicitWidth should be 16")

        // Remove Style
        btn.controlStyle = KaakaoControlButton.ControlStyle.Remove
        compare(btn.controlStyle, KaakaoControlButton.ControlStyle.Remove, "Style should be Remove")
        compare(btn.implicitWidth, 16, "Remove style implicitWidth should be 16")

        // Gear Style
        btn.controlStyle = KaakaoControlButton.ControlStyle.Gear
        compare(btn.controlStyle, KaakaoControlButton.ControlStyle.Gear, "Style should be Gear")
        compare(btn.implicitWidth, 16, "Gear style implicitWidth should be 16")

        // Info Style
        btn.controlStyle = KaakaoControlButton.ControlStyle.Info
        compare(btn.controlStyle, KaakaoControlButton.ControlStyle.Info, "Style should be Info")
        compare(btn.implicitWidth, 16, "Info style implicitWidth should be 16")

        // Refresh Style
        btn.controlStyle = KaakaoControlButton.ControlStyle.Refresh
        compare(btn.controlStyle, KaakaoControlButton.ControlStyle.Refresh, "Style should be Refresh")
        compare(btn.implicitWidth, 16, "Refresh style implicitWidth should be 16")

        // Play Style
        btn.controlStyle = KaakaoControlButton.ControlStyle.Play
        compare(btn.controlStyle, KaakaoControlButton.ControlStyle.Play, "Style should be Play")
        compare(btn.implicitWidth, 16, "Play style implicitWidth should be 16")

        // Pause Style
        btn.controlStyle = KaakaoControlButton.ControlStyle.Pause
        compare(btn.controlStyle, KaakaoControlButton.ControlStyle.Pause, "Style should be Pause")
        compare(btn.implicitWidth, 16, "Pause style implicitWidth should be 16")

        // Next Style
        btn.controlStyle = KaakaoControlButton.ControlStyle.Next
        compare(btn.controlStyle, KaakaoControlButton.ControlStyle.Next, "Style should be Next")
        compare(btn.implicitWidth, 16, "Next style implicitWidth should be 16")

        // Previous Style
        btn.controlStyle = KaakaoControlButton.ControlStyle.Previous
        compare(btn.controlStyle, KaakaoControlButton.ControlStyle.Previous, "Style should be Previous")
        compare(btn.implicitWidth, 16, "Previous style implicitWidth should be 16")
    }
}
