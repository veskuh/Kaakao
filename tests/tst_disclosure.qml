import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "DisclosureTriangleTests"
    width: 400
    height: 400
    visible: true

    KaakaoDisclosureTriangle {
        id: testDisclosure
        anchors.centerIn: parent
        text: "More Info"
    }

    function test_disclosure_toggle() {
        compare(testDisclosure.expanded, false, "Should be collapsed initially")
        
        mouseClick(testDisclosure)
        compare(testDisclosure.expanded, true, "Should be expanded after click")
        
        mouseClick(testDisclosure)
        compare(testDisclosure.expanded, false, "Should be collapsed after second click")
    }

    function test_disclosure_label() {
        compare(testDisclosure.text, "More Info", "Label text should be set")
    }
}
