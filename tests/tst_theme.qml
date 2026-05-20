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

        // Selection colors
        verify(Theme.selectionBackgroundActive !== undefined, "selectionBackgroundActive should be defined")
        verify(Theme.selectionBackgroundInactive !== undefined, "selectionBackgroundInactive should be defined")
        verify(Theme.selectionTextActive !== undefined, "selectionTextActive should be defined")
        verify(Theme.selectionTextInactive !== undefined, "selectionTextInactive should be defined")

        // Alternating rows
        verify(Theme.alternatingRowBackgroundEven !== undefined, "alternatingRowBackgroundEven should be defined")
        verify(Theme.alternatingRowBackgroundOdd !== undefined, "alternatingRowBackgroundOdd should be defined")

        // Table headers
        verify(Theme.headerBackgroundGradTop !== undefined, "headerBackgroundGradTop should be defined")
        verify(Theme.headerBackgroundGradBottom !== undefined, "headerBackgroundGradBottom should be defined")
        verify(Theme.headerBorder !== undefined, "headerBorder should be defined")
        verify(Theme.headerDivider !== undefined, "headerDivider should be defined")

        // Segmented Control
        verify(Theme.segmentedSelectionGradTop !== undefined, "segmentedSelectionGradTop should be defined")
        verify(Theme.segmentedSelectionGradBottom !== undefined, "segmentedSelectionGradBottom should be defined")

        // Search Field
        verify(Theme.searchFieldClearButton !== undefined, "searchFieldClearButton should be defined")
        verify(Theme.searchFieldClearButtonPressed !== undefined, "searchFieldClearButtonPressed should be defined")

        // Accent / Misc
        verify(Theme.accentButtonText !== undefined, "accentButtonText should be defined")
        verify(Theme.colorNone !== undefined, "colorNone should be defined")
    }

    function test_geometry() {
        compare(Theme.radiusStandard, 4, "Standard radius should be 4")
        compare(Theme.radiusSmall, 3, "Small radius should be 3")
        compare(Theme.radiusLarge, 10, "Large radius should be 10")
        compare(Theme.radiusMenu, 5, "Menu radius should be 5")
        compare(Theme.radiusPopup, 6, "Popup radius should be 6")
    }
}
