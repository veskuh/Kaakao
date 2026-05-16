import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "GridViewTests"
    width: 400
    height: 400
    visible: true

    Component {
        id: gridComp
        KaakaoGridView {
            width: 400
            height: 400
            cellWidth: 100
            cellHeight: 100
            model: ListModel {
                ListElement { name: "Item 0" }
                ListElement { name: "Item 1" }
                ListElement { name: "Item 2" }
            }
            delegate: KaakaoGridDelegate {
                objectName: "delegate_" + index
                width: 100
                height: 100
                Text { text: model.name }
            }
        }
    }

    function test_initialization() {
        let view = createTemporaryObject(gridComp, null)
        verify(view, "GridView created")
        compare(view.model.count, 3)
        
        wait(100)
        let d0 = findChild(view, "delegate_0")
        verify(d0, "Delegate 0 exists")
    }

    function test_selection() {
        let view = createTemporaryObject(gridComp, null)
        view.currentIndex = 1
        wait(100)
        
        let d1 = findChild(view, "delegate_1")
        verify(d1.isSelected, "Delegate 1 is selected")
        
        view.currentIndex = 2
        compare(view.currentIndex, 2)
        verify(findChild(view, "delegate_2").isSelected, "Delegate 2 is selected")
    }
}
