import QtQuick
import QtTest
import Kaakao
import Gallery

TestCase {
    name: "AboutWindowTests"
    width: 400
    height: 400
    visible: false

    AboutWindow {
        id: testAbout
        appName: "Test App"
        version: "1.2.3"
    }

    function test_initialization() {
        verify(testAbout !== null, "AboutWindow should be created")
        compare(testAbout.appName, "Test App", "App name should match")
        compare(testAbout.version, "1.2.3", "Version should match")
    }

    function test_fixed_size() {
        // Classic macOS About boxes should not be resizable
        compare(testAbout.width, testAbout.minimumWidth, "Width should be fixed")
        compare(testAbout.height, testAbout.minimumHeight, "Height should be fixed")
    }
}
