import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "KaakaoListView"
    width: 400
    height: 400
    visible: true
    when: windowShown

    Component {
        id: listComponent
        KaakaoListView {
            width: 200
            height: 200
            model: ["Item 0", "Item 1", "Item 2", "Item 3"]
            delegate: KaakaoListDelegate {
                text: modelData
                objectName: "delegate_" + index
            }
        }
    }

    function test_zebra_striping() {
        let view = createTemporaryObject(listComponent, this)
        verify(view, "View should be created")
        
        // Let it initialize. currentIndex 0 is selected by default.
        wait(100)
        
        let d1 = findChild(view, "delegate_1")
        let d2 = findChild(view, "delegate_2")
        
        verify(d1, "Delegate 1 should exist")
        verify(d2, "Delegate 2 should exist")
        
        // d1 (index 1) is odd, d2 (index 2) is even.
        // Neither is selected (index 0 is selected).
        let oddColor = Theme.isDarkMode ? "#2E2E2E" : "#F4F5F5"
        let evenColor = Theme.isDarkMode ? "#252525" : "#FFFFFF"
        
        // Use Qt.color to avoid case sensitivity issues in string comparison
        compare(d1.background.color, Qt.color(oddColor), "Odd row background color")
        compare(d2.background.color, Qt.color(evenColor), "Even row background color")
    }

    function test_selection_logic() {
        let view = createTemporaryObject(listComponent, this)
        view.currentIndex = 1
        wait(100)
        
        let d1 = findChild(view, "delegate_1")
        verify(d1.isSelected, "Delegate 1 should be selected")
        
        // Determine expected color based on actual focus
        let expectedColor;
        if (view.activeFocus) {
            expectedColor = Theme.primaryAccent;
        } else {
            expectedColor = Theme.isDarkMode ? "#444444" : "#DCDCDC";
        }
        
        compare(d1.background.color, Qt.color(expectedColor), "Selected row color matches focus state")
        
        // If it has focus, check text inversion
        if (view.activeFocus) {
            let textItem = findChild(d1, "titleLabel")
            verify(textItem, "Title label should exist")
            compare(textItem.color, Qt.color("#FFFFFF"), "Text color should be inverted to white when focused")
        }
    }

    function test_keyboard_navigation_basic() {
        let view = createTemporaryObject(listComponent, this)
        view.currentIndex = 0
        
        view.incrementCurrentIndex()
        compare(view.currentIndex, 1, "Incrementing index works")
        
        view.decrementCurrentIndex()
        compare(view.currentIndex, 0, "Decrementing index works")
    }

    function test_mouse_click_selection() {
        let view = createTemporaryObject(listComponent, this)
        view.currentIndex = 0
        wait(100)
        
        let d2 = findChild(view, "delegate_2")
        verify(d2, "Delegate 2 should exist")
        
        mouseClick(d2)
        wait(50)
        compare(view.currentIndex, 2, "Mouse click updates currentIndex")
        verify(view.activeFocus, "Mouse click gives focus to the view")
    }
}
