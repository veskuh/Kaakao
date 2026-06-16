import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "ScopeBarTests"
    width: 400
    height: 400
    visible: true

    Component {
        id: scopeBarComp
        KaakaoScopeBar {
            model: ["All", "Images", "Documents"]
        }
    }

    function test_scopebar_selection() {
        let bar = createTemporaryObject(scopeBarComp, null)
        verify(bar, "ScopeBar created successfully")
        compare(bar.currentIndex, 0, "Default index should be 0")
        compare(bar.model.length, 3, "Should have 3 items")

        // Track signals
        let signalSpy = createTemporaryObject(signalSpyComp, null, {
            target: bar,
            signalName: "filterSelected"
        })

        // Change index
        bar.currentIndex = 1
        compare(bar.currentIndex, 1, "Index should update to 1")

        // Manually clicking/activating the button should be tested, but property update is verified.
    }

    function test_scopebar_overflow() {
        let bar = createTemporaryObject(scopeBarComp, null)
        verify(bar, "ScopeBar created successfully")
        
        // Large width - should have no overflow
        bar.width = 500
        bar.updateLayout()
        compare(bar.hasOverflow, false, "Should not have overflow when wide enough")
        compare(bar.overflowItems.length, 0, "Overflow list should be empty")

        // Narrow width - should trigger overflow
        bar.width = 120
        bar.updateLayout()
        compare(bar.hasOverflow, true, "Should have overflow when too narrow")
        verify(bar.overflowItems.length > 0, "Overflow list should contain items")
        compare(bar.overflowItems[0].text, "Images", "Second item should overflow when very narrow")
    }

    Component {
        id: signalSpyComp
        SignalSpy {}
    }
}
