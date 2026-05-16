import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "SplitViewTests"
    width: 400
    height: 400
    visible: true

    Component {
        id: splitComp
        KaakaoSplitView {
            width: 400
            height: 400
            orientation: Qt.Horizontal
            
            Rectangle { 
                objectName: "leftPane"
                SplitView.preferredWidth: 100 
                color: "red"
            }
            Rectangle { 
                objectName: "rightPane"
                SplitView.fillWidth: true 
                color: "blue"
            }
        }
    }

    function test_initialization() {
        let view = createTemporaryObject(splitComp, null)
        verify(view, "SplitView created")
        compare(view.orientation, Qt.Horizontal)
        
        let left = findChild(view, "leftPane")
        let right = findChild(view, "rightPane")
        verify(left && right, "Panes found")
        compare(left.width, 100)
    }

    function test_orientation() {
        let view = createTemporaryObject(splitComp, null, { orientation: Qt.Vertical })
        compare(view.orientation, Qt.Vertical)
    }
}
