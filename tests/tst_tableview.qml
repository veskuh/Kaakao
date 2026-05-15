import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "KaakaoTableView"
    width: 600
    height: 400
    visible: true
    when: windowShown

    Component {
        id: tableComponent
        KaakaoTableView {
            width: 400
            height: 300
            columns: [
                KaakaoTableColumn { title: "Col 1"; role: "role1"; width: 100 },
                KaakaoTableColumn { title: "Col 2"; role: "role2"; width: 100 }
            ]
            model: ListModel {
                ListElement { role1: "A"; role2: "Z" }
                ListElement { role1: "B"; role2: "Y" }
            }
        }
    }

    function test_column_resizing() {
        let table = createTemporaryObject(tableComponent, this)
        verify(table, "Table should be created")
        
        // Give it time to layout
        wait(200)
        
        let col1 = table.columns[0]
        let initialWidth = col1.width
        compare(initialWidth, 100, "Initial width is 100")
        
        let resizeHandle = findChild(table, "resizeHandle_0")
        verify(resizeHandle, "Resize handle 0 should exist")
        
        // Simulate drag: Press, Move, Release
        // The handle is 8px wide, let's hit the center (4, height/2)
        let centerX = resizeHandle.width / 2
        let centerY = resizeHandle.height / 2
        
        mousePress(resizeHandle, centerX, centerY)
        // Move 50px to the right relative to the handle's initial position
        // Since the handle moves with the edge, we use mouseMove on the handle itself
        // but it might be safer to move relative to a stable parent if the test framework allows.
        // mouseMove(item, x, y) sets the mouse position relative to 'item'.
        for (let i = 1; i <= 10; i++) {
            mouseMove(resizeHandle, centerX + (i * 5), centerY)
            wait(10)
        }
        mouseRelease(resizeHandle, centerX + 50, centerY)
        
        wait(100)
        verify(col1.width > initialWidth, "Column width should increase. New width: " + col1.width)
    }

    function test_sorting_state() {
        let table = createTemporaryObject(tableComponent, this)
        wait(200)

        let col1 = table.columns[0]
        compare(col1.sortOrder, -1, "Initially unsorted")

        let clickArea = findChild(table, "headerClickArea_0")
        verify(clickArea, "Click area should exist")
        
        mouseClick(clickArea)
        wait(100)
        compare(col1.sortOrder, Qt.AscendingOrder, "First click sorts ascending")
        
        mouseClick(clickArea)
        wait(100)
        compare(col1.sortOrder, Qt.DescendingOrder, "Second click sorts descending")
    }
}
