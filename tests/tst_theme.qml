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

        // ToolBar properties
        verify(Theme.toolbarGradTop !== undefined, "toolbarGradTop should be defined")
        verify(Theme.toolbarGradBottom !== undefined, "toolbarGradBottom should be defined")
        verify(Theme.toolbarBorder !== undefined, "toolbarBorder should be defined")
        verify(Theme.toolbarHighlight !== undefined, "toolbarHighlight should be defined")
        verify(Theme.toolButtonHovered !== undefined, "toolButtonHovered should be defined")
        verify(Theme.toolButtonPressed !== undefined, "toolButtonPressed should be defined")
        verify(Theme.toolButtonBorder !== undefined, "toolButtonBorder should be defined")

        // Sidebar properties
        verify(Theme.sidebarBackground !== undefined, "sidebarBackground should be defined")
        verify(Theme.sidebarBorder !== undefined, "sidebarBorder should be defined")
        verify(Theme.sidebarSectionText !== undefined, "sidebarSectionText should be defined")
    }

    function test_geometry() {
        compare(Theme.radiusStandard, 4, "Standard radius should be 4")
        compare(Theme.radiusSmall, 3, "Small radius should be 3")
        compare(Theme.radiusLarge, 10, "Large radius should be 10")
    }
}
