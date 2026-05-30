import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "UntestedComponentsTests"
    width: 500
    height: 500
    visible: false

    // 1. KaakaoActivityOverlay Component
    Component {
        id: overlayComponent
        KaakaoActivityOverlay {
            text: "Loading System Settings..."
        }
    }

    function test_01_activity_overlay() {
        let overlay = createTemporaryObject(overlayComponent, this)
        verify(overlay !== null, "Overlay should be created")
        compare(overlay.text, "Loading System Settings...", "Overlay text should match configured value")
        compare(overlay.active, false, "Overlay should not be active initially")
        compare(overlay.opacity, 0.0, "Overlay opacity should be 0 initially")

        // Activate the overlay
        overlay.active = true
        // Let the 200ms opacity transition behavior finish
        tryCompare(overlay, "opacity", 1.0)
        compare(overlay.active, true, "Overlay active state should be true")

        // Deactivate the overlay
        overlay.active = false
        // Let the 200ms opacity transition behavior finish
        tryCompare(overlay, "opacity", 0.0)
        compare(overlay.active, false, "Overlay active state should be false")
    }

    // 2. KaakaoPathControl Component
    property string lastClickedPath: "none"
    Component {
        id: pathControlComponent
        KaakaoPathControl {
            path: "Documents/Work/Kaakao"
            rootLabel: "Finder"
            onPathClicked: (targetPath) => lastClickedPath = targetPath
        }
    }

    function test_02_path_control() {
        let pathCtrl = createTemporaryObject(pathControlComponent, this)
        verify(pathCtrl !== null, "PathControl should be created")
        compare(pathCtrl.rootLabel, "Finder", "Root label should match")
        compare(pathCtrl.path, "Documents/Work/Kaakao", "Path should match")

        // The split path should produce 4 segments: Finder (root), Documents, Work, Kaakao
        let segmentsCount = 0
        for (let i = 0; i < pathCtrl.children.length; ++i) {
            // Count rows created by repeater delegate
            if (pathCtrl.children[i].spacing !== undefined) {
                segmentsCount++
            }
        }
        compare(segmentsCount, 4, "Should create 4 path segments")

        // Test clicked signal by finding the MouseArea of the second segment (Documents)
        let docSegment = pathCtrl.children[1] // Row
        let docLabel = docSegment.children[1] // KaakaoLabel
        let docMouseArea = docLabel.children[0] // MouseArea inside label

        // Verify the MouseArea is enabled for non-last items
        verify(docMouseArea.enabled, "MouseArea should be enabled for middle segments")

        // Trigger signal directly (since running in headless mode, window clicks aren't dispatched)
        lastClickedPath = "none"
        docMouseArea.clicked(null)
        wait(50)
        compare(lastClickedPath, "Documents", "PathClicked signal should yield correct target path")

        // The last segment (Kaakao) mouse area should be disabled (cannot click active leaf)
        let leafSegment = pathCtrl.children[3]
        let leafLabel = leafSegment.children[1]
        let leafMouseArea = leafLabel.children[0]
        verify(!leafMouseArea.enabled, "MouseArea should be disabled for the last segment")
    }

    // 3. KaakaoStatusBar Component
    Component {
        id: statusBarComponent
        KaakaoStatusBar {
            spacing: 12
            leftPadding: 10
            rightPadding: 10
            KaakaoLabel { id: childLabel; text: "Ready" }
        }
    }

    function test_03_status_bar() {
        let statusBar = createTemporaryObject(statusBarComponent, this)
        verify(statusBar !== null, "StatusBar should be created")
        compare(statusBar.implicitHeight, 28, "StatusBar should have classic height of 28px")
        compare(statusBar.spacing, 12, "StatusBar spacing alias should match")
        compare(statusBar.leftPadding, 10, "Left padding should match")
        compare(statusBar.rightPadding, 10, "Right padding should match")

        // Find the internal RowLayout
        let layout = null
        for (let i = 0; i < statusBar.children.length; ++i) {
            if (statusBar.children[i].anchors !== undefined && statusBar.children[i].spacing !== undefined) {
                layout = statusBar.children[i]
                break
            }
        }
        verify(layout !== null, "RowLayout inside StatusBar should exist")
        compare(layout.spacing, 12, "Internal layout spacing should match")
    }

    // 4. KaakaoStatusIndicator Component
    Component {
        id: statusIndicatorComponent
        KaakaoStatusIndicator {}
    }

    function test_04_status_indicator() {
        let ind = createTemporaryObject(statusIndicatorComponent, this)
        verify(ind !== null, "StatusIndicator should be created")
        compare(ind.status, "none", "Default status should be none")
        compare(ind.color, Qt.color(Theme.colorNone), "Default color should be Theme.colorNone")

        ind.status = "success"
        compare(ind.color, Qt.color(Theme.colorSuccess), "Success color should be Theme.colorSuccess")

        ind.status = "error"
        compare(ind.color, Qt.color(Theme.colorError), "Error color should be Theme.colorError")

        ind.status = "warning"
        compare(ind.color, Qt.color(Theme.colorWarning), "Warning color should be Theme.colorWarning")

        ind.status = "info"
        compare(ind.color, Qt.color(Theme.colorInfo), "Info color should be Theme.colorInfo")
    }

    // 5. KaakaoFocusRing Component
    Component {
        id: focusRingComponent
        Item {
            id: container
            width: 100
            height: 100
            focus: false

            KaakaoFocusRing {
                id: ring
            }
        }
    }

    function test_05_focus_ring() {
        let container = createTemporaryObject(focusRingComponent, this)
        verify(container !== null, "Container should be created")
        
        let ring = container.children[0]
        verify(ring !== null, "FocusRing should be created")
        compare(ring.active, false, "FocusRing should not be active initially")
        compare(ring.opacity, 0.0, "FocusRing opacity should be 0 initially")

        // Force focus on the parent container
        container.focus = true
        // Let the 80ms opacity transition behavior finish
        tryCompare(ring, "opacity", 0.4)
        compare(ring.active, true, "FocusRing should activate when target gets focus")

        // Unfocus target
        container.focus = false
        // Let the 80ms opacity transition behavior finish
        tryCompare(ring, "opacity", 0.0)
        compare(ring.active, false, "FocusRing should deactivate when target loses focus")

        // Change ring settings
        ring.focusRadius = 15
        compare(ring.focusRadius, 15, "FocusRadius setting should update")
        ring.ringWidth = 5
        compare(ring.ringWidth, 5, "RingWidth setting should update")
    }
}
