pragma Singleton
import QtQuick

QtObject {
    id: theme

    // Mode detection
    property bool isDarkMode: Qt.styleHints.colorScheme === Qt.ColorScheme.Dark

    // Base Colors
    readonly property color primaryAccent: isDarkMode ? "#0A84FF" : "#007AFF"
    readonly property color windowBackground: isDarkMode ? "#1E1E1E" : "#ECECEC"
    readonly property color contentBackground: isDarkMode ? "#252525" : "#FFFFFF"
    readonly property color primaryText: isDarkMode ? "#DEDEDE" : "#222222"
    readonly property real disabledOpacity: 0.4

    // Button Colors (Classical macOS Yosemite-Catalina)
    readonly property color buttonGradTop: isDarkMode ? "#5C5C5C" : "#FFFFFF"
    readonly property color buttonGradBottom: isDarkMode ? "#454545" : "#E6E6E6"
    readonly property color buttonBorder: isDarkMode ? "#2A2A2A" : "#C4C4C4"
    readonly property color buttonHighlight: isDarkMode ? Qt.rgba(1,1,1,0.1) : Qt.rgba(1,1,1,0.8)
    readonly property color buttonPressed: isDarkMode ? "#3A3A3A" : "#D9D9D9"
    readonly property color buttonShadow: Qt.rgba(0,0,0, isDarkMode ? 0.3 : 0.05)

    // Primary/Accent Button
    readonly property color accentGradTop: isDarkMode ? "#3AB2FF" : "#34A1FF"
    readonly property color accentGradBottom: isDarkMode ? "#0A84FF" : "#007AFF"
    readonly property color accentBorder: isDarkMode ? "#004080" : "#0058B0"

    // Geometry
    readonly property real radiusStandard: 4
    readonly property real radiusSmall: 3
    readonly property real radiusLarge: 10

    // Typography
    readonly property font defaultFont: Qt.font({
        family: Qt.platform.os === "osx" ? ".AppleSystemUIFont" : "sans-serif",
        pixelSize: 13,
        weight: Font.Normal
    })
}
