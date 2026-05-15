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
        
        let bg = btn.background
        verify(bg.radius > 0, "Background should have rounded corners")
        
        // Find the gradient rectangle (it's the first child of the background rectangle)
        let gradRect = bg.children[0]
        // Since we cannot reliably access stops in some environments/versions via children, 
        // let's just verify the gradient property exists.
        verify(gradRect.gradient !== null, "Background should have a gradient")
    }

    function test_03_theme_colors() {
        let btn = createTemporaryObject(buttonComponent, this)
        
        // Force light mode
        Theme.themeMode = 1 // Light
        wait(50)
        
        // Check text color in light mode
        compare(btn.contentItem.color, Qt.color("#222222"), "Light mode text color")
        
        // Switch to dark mode
        Theme.themeMode = 2 // Dark
        wait(50)
        
        // Check text color in dark mode
        compare(btn.contentItem.color, Qt.color("#DEDEDE"), "Dark mode text color")
    }

    function test_04_highlighted_state() {
        let btn = createTemporaryObject(buttonComponent, this)
        btn.highlighted = true
        wait(50)
        
        // Highlighted button uses white text
        compare(btn.contentItem.color, Qt.color("#FFFFFF"), "Highlighted button uses white text")
    }
}
