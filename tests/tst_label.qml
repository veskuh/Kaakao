import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "LabelTests"
    width: 400
    height: 400
    visible: false

    Column {
        KaakaoLabel { id: primaryLabel; text: "Primary" }
        KaakaoLabel { id: headerLabel; text: "Header"; role: KaakaoLabel.Role.Header }
        KaakaoLabel { id: smallLabel; text: "Small"; role: KaakaoLabel.Role.Small }
        KaakaoLabel { id: secondaryLabel; text: "Secondary"; role: KaakaoLabel.Role.Secondary }
    }

    function test_roles() {
        // Primary
        compare(primaryLabel.font.pixelSize, 13, "Primary should be 13px")
        compare(primaryLabel.opacity, 1.0, "Primary should be fully opaque")

        // Header
        compare(headerLabel.font.pixelSize, 15, "Header should be 15px")
        compare(headerLabel.font.weight, Font.Bold, "Header should be bold")

        // Small
        compare(smallLabel.font.pixelSize, 11, "Small should be 11px")
        compare(smallLabel.opacity, 0.7, "Small should have secondary opacity")

        // Secondary
        compare(secondaryLabel.font.pixelSize, 13, "Secondary should be 13px")
        compare(secondaryLabel.opacity, 0.7, "Secondary should have reduced opacity")
    }

    function test_disabled_state() {
        primaryLabel.enabled = false
        compare(primaryLabel.opacity, Theme.disabledOpacity, "Disabled label should have theme disabled opacity")
        primaryLabel.enabled = true
    }
}
