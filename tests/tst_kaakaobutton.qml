import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "KaakaoButtonTests"
    width: 400
    height: 400
    visible: true
    when: windowShown

    Component {
        id: buttonComponent
        KaakaoButton {
            text: "Test Button"
        }
    }

    function test_01_initialization() {
        let btn = createTemporaryObject(buttonComponent, this)
        compare(btn.text, "Test Button", "Text should match initial value")
        compare(btn.implicitHeight, 22, "Button should have classic macOS height")
    }

    function test_02_visual_structure() {
        let btn = createTemporaryObject(buttonComponent, this)
        verify(btn.background !== null, "Background should exist")
        
        // Find the main rectangle inside the background Item
        let bgItem = btn.background
        let mainRect = bgItem.children[0]
        verify(mainRect.radius > 0, "Background should have rounded corners")
        
        // Find the gradient rectangle
        let gradRect = mainRect.children[0]
        verify(gradRect.gradient !== null, "Background should have a gradient")
    }

    function test_03_theme_colors() {
        let btn = createTemporaryObject(buttonComponent, this)
        
        // Force light mode first
        Theme.themeMode = 1 // Light
        wait(50)
        
        let bgItem = btn.background
        let mainRect = bgItem.children[0]
        let gradRect = mainRect.children[0]
        
        // Check light mode top gradient color (should be Theme.buttonGradTop)
        compare(gradRect.gradient.stops[0].color, Qt.color("#FFFFFF"), "Light mode top color")
        
        // Switch to dark mode
        Theme.themeMode = 2 // Dark
        wait(50)
        
        // Check dark mode top gradient color (should be Theme.buttonGradTop)
        compare(gradRect.gradient.stops[0].color, Qt.color("#5C5C5C"), "Dark mode top color")
    }

    function test_04_highlighted_state() {
        let btn = createTemporaryObject(buttonComponent, this)
        btn.highlighted = true
        wait(50)
        
        let bgItem = btn.background
        let mainRect = bgItem.children[0]
        let gradRect = mainRect.children[0]
        
        // In dark mode (still active from previous test), highlighted button uses accent colors
        compare(gradRect.gradient.stops[0].color, Theme.accentGradTop, "Highlighted button uses accent gradient")
        compare(btn.contentItem.color, Qt.color("#FFFFFF"), "Highlighted button uses white text")
    }
}
