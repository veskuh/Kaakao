import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "WindowTests"
    width: 400
    height: 400
    visible: false

    KaakaoWindow {
        id: testWindow
        title: "Test Window"
    }

    function test_initialization() {
        verify(testWindow !== null, "Window should be created")
        compare(testWindow.title, "Test Window", "Title should match")
        compare(testWindow.color, Theme.windowBackground, "Background color should follow theme")
    }

    function test_font_inheritance() {
        compare(testWindow.font.pixelSize, Theme.defaultFont.pixelSize, "Window should inherit theme font size")
    }
}
