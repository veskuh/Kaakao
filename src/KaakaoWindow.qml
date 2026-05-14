import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype KaakaoWindow
    \inqmlmodule Kaakao
    \brief The primary application window with Kaakao styling.
    \inherits QtQuick.Controls.ApplicationWindow

    KaakaoWindow serves as the root container for applications using the Kaakao
    toolkit. It automatically applies the theme's background color and default font.
*/
ApplicationWindow {
    id: window
    width: 640
    height: 480
    
    font: Theme.defaultFont
    color: Theme.windowBackground

    // Ensure children inherit the correct theme background if needed
    // but primarily ApplicationWindow handles the root color.
}
