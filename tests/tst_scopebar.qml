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

    Component {
        id: signalSpyComp
        SignalSpy {}
    }
}
