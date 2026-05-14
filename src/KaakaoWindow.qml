import QtQuick
import QtQuick.Controls.Basic
import Kaakao

ApplicationWindow {
    id: window
    
    visible: true
    width: 640
    height: 480
    
    font: Theme.defaultFont
    color: Theme.windowBackground

    // Ensure children inherit the correct theme background if needed
    // but primarily ApplicationWindow handles the root color.
}
