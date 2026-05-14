import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "SidebarTests"
    width: 400
    height: 400
    visible: true

    KaakaoSidebar {
        id: testSidebar
        model: ListModel {
            ListElement { name: "Item 1"; category: "Cat A" }
            ListElement { name: "Item 2"; category: "Cat A" }
            ListElement { name: "Item 3"; category: "Cat B" }
        }
    }

    function test_sidebar_metrics() {
        compare(testSidebar.implicitWidth, 200, "Default implicitWidth should be 200")
        compare(testSidebar.sidebarWidth, 200, "Default sidebarWidth should be 200")
    }

    function test_sidebar_collapse() {
        testSidebar.collapsed = true
        // Animation takes time, but implicitWidth property updates immediately or via behavior
        // Since we want to test the end state, we can use tryCompare or wait
        tryCompare(testSidebar, "implicitWidth", 0, 500)
        
        testSidebar.collapsed = false
        tryCompare(testSidebar, "implicitWidth", 200, 500)
    }

    function test_sidebar_selection() {
        compare(testSidebar.currentIndex, 0, "Initial selection should be 0")
        testSidebar.currentIndex = 2
        compare(testSidebar.currentIndex, 2, "Selection should update to 2")
    }

    function test_sidebar_model() {
        verify(testSidebar.model.count === 3, "Model should have 3 items")
    }
}
