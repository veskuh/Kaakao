pragma Singleton
import QtQuick

/*!
    \qmltype Theme
    \inqmlmodule Kaakao
    \brief Provides the visual identity and styling constants for the Kaakao toolkit (Singleton).

    The Theme singleton manages color schemes, geometry, and typography across all
    Kaakao components, supporting both light and dark modes according to system settings.
*/
QtObject {
    id: theme

    // Mode detection
    /*! \qmlproperty bool Theme::isDarkMode
        True if the system is currently using a dark color scheme.
    */
    property bool isDarkMode: Qt.styleHints.colorScheme === Qt.ColorScheme.Dark

    // Base Colors
    /*! \qmlproperty color Theme::primaryAccent
        The main accent color used for focus rings, selections, and primary buttons.
    */
    readonly property color primaryAccent: isDarkMode ? "#0A84FF" : "#007AFF"
    
    /*! \qmlproperty color Theme::windowBackground
        The default background color for windows and dialogs.
    */
    readonly property color windowBackground: isDarkMode ? "#1E1E1E" : "#ECECEC"
    
    /*! \qmlproperty color Theme::contentBackground
        The background color for content areas like text fields.
    */
    readonly property color contentBackground: isDarkMode ? "#252525" : "#FFFFFF"
    
    /*! \qmlproperty color Theme::primaryText
        The standard color for text content.
    */
    readonly property color primaryText: isDarkMode ? "#DEDEDE" : "#222222"
    
    /*! \qmlproperty real Theme::disabledOpacity
        The opacity level applied to disabled components.
    */
    readonly property real disabledOpacity: 0.4

    // Button Colors (Classical macOS Yosemite-Catalina)
    /*! \qmlproperty color Theme::buttonGradTop
        The top color of the standard button gradient.
    */
    readonly property color buttonGradTop: isDarkMode ? "#5C5C5C" : "#FFFFFF"
    
    /*! \qmlproperty color Theme::buttonGradBottom
        The bottom color of the standard button gradient.
    */
    readonly property color buttonGradBottom: isDarkMode ? "#454545" : "#E6E6E6"
    
    /*! \qmlproperty color Theme::buttonBorder
        The border color for buttons and other framed components.
    */
    readonly property color buttonBorder: isDarkMode ? "#2A2A2A" : "#C4C4C4"
    
    /*! \qmlproperty color Theme::buttonHighlight
        A subtle highlight color applied to the top edge of buttons.
    */
    readonly property color buttonHighlight: isDarkMode ? Qt.rgba(1,1,1,0.1) : Qt.rgba(1,1,1,0.8)
    
    /*! \qmlproperty color Theme::buttonPressed
        The solid background color used when a button is in the pressed state.
    */
    readonly property color buttonPressed: isDarkMode ? "#3A3A3A" : "#D9D9D9"
    
    /*! \qmlproperty color Theme::buttonShadow
        The color of the subtle drop shadow applied to buttons.
    */
    readonly property color buttonShadow: Qt.rgba(0,0,0, isDarkMode ? 0.3 : 0.05)

    // TextField Colors
    /*! \qmlproperty color Theme::textFieldBorder
        The border color for text input fields.
    */
    readonly property color textFieldBorder: isDarkMode ? "#1A1A1A" : "#B0B0B0"
    
    /*! \qmlproperty color Theme::textFieldInnerShadow
        The color of the inner shadow that creates the "sunken well" aesthetic in text fields.
    */
    readonly property color textFieldInnerShadow: isDarkMode ? Qt.rgba(0,0,0,0.5) : Qt.rgba(0,0,0,0.15)

    // ToolBar Colors
    readonly property color toolbarGradTop: isDarkMode ? "#3C3C3C" : "#F6F6F6"
    readonly property color toolbarGradBottom: isDarkMode ? "#323232" : "#E8E8E8"
    readonly property color toolbarBorder: isDarkMode ? "#000000" : "#B0B0B0"
    readonly property color toolbarHighlight: isDarkMode ? Qt.rgba(1,1,1,0.05) : Qt.rgba(1,1,1,0.8)
    readonly property color toolButtonHovered: isDarkMode ? "#2A2A2A" : "#E6E6E6"
    readonly property color toolButtonPressed: isDarkMode ? "#3A3A3A" : "#D9D9D9"
    readonly property color toolButtonBorder: isDarkMode ? "#121212" : "#B0B0B0"

    // Primary/Accent Button
    /*! \qmlproperty color Theme::accentGradTop
        The top color of the primary accent button gradient.
    */
    readonly property color accentGradTop: isDarkMode ? "#3AB2FF" : "#34A1FF"
    
    /*! \qmlproperty color Theme::accentGradBottom
        The bottom color of the primary accent button gradient.
    */
    readonly property color accentGradBottom: isDarkMode ? "#0A84FF" : "#007AFF"
    
    /*! \qmlproperty color Theme::accentBorder
        The border color for primary accent buttons.
    */
    readonly property color accentBorder: isDarkMode ? "#004080" : "#0058B0"

    // Geometry
    /*! \qmlproperty real Theme::radiusStandard
        The standard corner radius (4px) used for buttons and most components.
    */
    readonly property real radiusStandard: 4
    
    /*! \qmlproperty real Theme::radiusSmall
        A smaller corner radius (3px) used for text fields and compact elements.
    */
    readonly property real radiusSmall: 3
    
    /*! \qmlproperty real Theme::radiusLarge
        A larger corner radius (10px) used for dialogs and windows.
    */
    readonly property real radiusLarge: 10

    // Typography
    /*! \qmlproperty font Theme::defaultFont
        The default system font used throughout the toolkit.
    */
    readonly property font defaultFont: Qt.font({
        family: Qt.platform.os === "osx" ? ".AppleSystemUIFont" : "sans-serif",
        pixelSize: 13,
        weight: Font.Normal
    })
}
