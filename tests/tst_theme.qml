import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "ThemeTests"
    
    function test_theme_properties() {
        verify(Theme.primaryAccent !== undefined, "primaryAccent should be defined")
        verify(Theme.windowBackground !== undefined, "windowBackground should be defined")
        verify(Theme.contentBackground !== undefined, "contentBackground should be defined")
        verify(Theme.primaryText !== undefined, "primaryText should be defined")
    }

    function test_geometry() {
        compare(Theme.radiusStandard, 4, "Standard radius should be 4")
        compare(Theme.radiusSmall, 3, "Small radius should be 3")
        compare(Theme.radiusLarge, 10, "Large radius should be 10")
    }
}
