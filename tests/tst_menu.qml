import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "KaakaoMenuTests"
    width: 400
    height: 400
    visible: true
    when: windowShown

    Component {
        id: menuComponent
        KaakaoMenu {
            KaakaoMenuItem { text: "Item 1"; shortcut: "⌘1" }
            KaakaoMenuItem { text: "Item 2"; checkable: true; checked: true }
            KaakaoMenuSeparator { }
            KaakaoMenuItem { text: "Item 3"; enabled: false }
            KaakaoMenu {
                title: "Submenu"
                KaakaoMenuItem { text: "Sub Item" }
            }
        }
    }

    function test_01_initialization() {
        let menu = createTemporaryObject(menuComponent, this)
        compare(menu.count, 5, "Menu should have 5 children")
    }

    function test_02_item_properties() {
        let menu = createTemporaryObject(menuComponent, this)
        
        let item1 = menu.itemAt(0)
        compare(item1.text, "Item 1", "Item text should match")
        compare(item1.shortcut, "⌘1", "Shortcut should match")
        
        let item2 = menu.itemAt(1)
        verify(item2.checkable, "Item 2 should be checkable")
        verify(item2.checked, "Item 2 should be checked")
        
        let item3 = menu.itemAt(3)
        verify(!item3.enabled, "Item 3 should be disabled")
    }

    function test_03_visual_structure() {
        let menu = createTemporaryObject(menuComponent, this)
        verify(menu.background !== null, "Menu background should exist")
        compare(menu.background.radius, 5, "Menu should have rounded corners")
        compare(menu.background.opacity, 0.98, "Menu should be semi-transparent")
    }

    function test_04_layout_logic() {
        let menu = createTemporaryObject(menuComponent, this)
        let item1 = menu.itemAt(0)
        
        // Ensure the item fills the menu width
        compare(item1.width, menu.contentItem.width, "Item should fill menu width")
        
        // Minimum width check
        verify(menu.implicitWidth >= 150, "Menu should respect minimum implicit width")
    }

    function test_05_separator() {
        let menu = createTemporaryObject(menuComponent, this)
        let sep = menu.itemAt(2)
        verify(sep.contentItem !== null, "Separator should have contentItem")
        compare(sep.implicitHeight, 11, "Separator should have standard height")
    }

    function test_06_disabled_state() {
        let menu = createTemporaryObject(menuComponent, this)
        let item3 = menu.itemAt(3) // Item 3 is disabled
        verify(!item3.enabled, "Item 3 should be disabled")
        
        // Find contentItem and check opacity
        let content = item3.contentItem
        verify(content !== null, "Content item should exist")
        compare(content.opacity, 0.5, "Disabled item should have 0.5 opacity")
        
        let item1 = menu.itemAt(0)
        verify(item1.enabled, "Item 1 should be enabled")
        compare(item1.contentItem.opacity, 1.0, "Enabled item should have 1.0 opacity")
    }
}
