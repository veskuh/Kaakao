import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "DialogTests"
    width: 400
    height: 400
    visible: false

    KaakaoDialog {
        id: testDialog
        title: "Test Dialog"
        
        Item {
            implicitWidth: 100
            implicitHeight: 100
        }
    }

    function test_initialization() {
        verify(testDialog !== null, "Dialog should be created")
        compare(testDialog.title, "Test Dialog", "Title should match")
    }

    function test_background() {
        verify(testDialog.background !== null, "Background should exist")
        compare(testDialog.background.radius, Theme.radiusLarge, "Dialog should have large corner radius")
    }

    function test_visibility() {
        testDialog.open()
        verify(testDialog.opened, "Dialog should be opened")
        testDialog.close()
        verify(!testDialog.opened, "Dialog should be closed")
    }
}
