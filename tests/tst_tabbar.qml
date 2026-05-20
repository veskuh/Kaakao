import QtQuick
import QtTest
import Kaakao

TestCase {
    name: "KaakaoTabBarTests"
    width: 400
    height: 400
    visible: true
    when: windowShown

    Component {
        id: tabBarComponent
        KaakaoTabBar {
            KaakaoTabButton { text: "General" }
            KaakaoTabButton { text: "Advanced" }
            KaakaoTabButton { text: "Plugins" }
        }
    }

    function test_01_initialization() {
        let bar = createTemporaryObject(tabBarComponent, this)
        compare(bar.currentIndex, 0, "Default currentIndex should be 0")
        compare(bar.count, 3, "Should have 3 tabs")
        compare(bar.spacing, 0, "Tabs should have zero spacing")
    }

    function test_02_tab_button_geometry() {
        let bar = createTemporaryObject(tabBarComponent, this)
        let tab = bar.itemAt(0)
        compare(tab.implicitHeight, 24, "Tab should have classic macOS tab height")
        verify(tab.implicitWidth >= 70, "Tab should have minimum width of 70")
    }

    function test_03_tab_switching() {
        let bar = createTemporaryObject(tabBarComponent, this)
        compare(bar.currentIndex, 0, "Starts at index 0")

        bar.currentIndex = 2
        wait(50)
        compare(bar.currentIndex, 2, "Should switch to index 2")

        let tab0 = bar.itemAt(0)
        let tab2 = bar.itemAt(2)
        verify(!tab0.checked, "Tab 0 should not be checked")
        verify(tab2.checked, "Tab 2 should be checked")
    }

    function test_04_visual_structure() {
        let bar = createTemporaryObject(tabBarComponent, this)
        let tab = bar.itemAt(0)

        verify(tab.background !== null, "Tab background should exist")
        verify(tab.contentItem !== null, "Tab contentItem should exist")
        compare(tab.contentItem.text, "General", "First tab text should be 'General'")
    }

    function test_05_theme_colors() {
        let bar = createTemporaryObject(tabBarComponent, this)
        let tab = bar.itemAt(0)

        // Force light mode
        Theme.themeMode = 1
        wait(50)
        compare(tab.contentItem.color, Qt.color("#222222"), "Light mode text color")

        // Switch to dark mode
        Theme.themeMode = 2
        wait(50)
        compare(tab.contentItem.color, Qt.color("#DEDEDE"), "Dark mode text color")

        // Reset
        Theme.themeMode = 0
    }

    function test_06_checked_opacity() {
        let bar = createTemporaryObject(tabBarComponent, this)
        let activeTab = bar.itemAt(0)
        let inactiveTab = bar.itemAt(1)

        compare(activeTab.contentItem.opacity, 1.0, "Active tab text should be fully opaque")
        compare(inactiveTab.contentItem.opacity, 0.7, "Inactive tab text should be dimmed")
    }
}
