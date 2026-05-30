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
}
