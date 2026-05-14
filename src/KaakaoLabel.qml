import QtQuick
import QtQuick.Controls.Basic
import Kaakao

Label {
    id: control

    enum Role {
        Primary,
        Secondary,
        Small,
        Header
    }

    property int role: KaakaoLabel.Role.Primary

    font.family: Theme.defaultFont.family
    font.pixelSize: {
        switch (role) {
            case KaakaoLabel.Role.Header: return 15;
            case KaakaoLabel.Role.Small: return 11;
            default: return 13;
        }
    }
    
    font.weight: role === KaakaoLabel.Role.Header ? Font.Bold : Font.Normal
    
    color: Theme.primaryText
    opacity: {
        if (!enabled) return Theme.disabledOpacity;
        switch (role) {
            case KaakaoLabel.Role.Secondary:
            case KaakaoLabel.Role.Small: 
                return 0.7;
            default: return 1.0;
        }
    }

    // Classic macOS labels often have a very subtle shadow or sharp rendering
    // but for standard labels, color and sizing are the primary spec.
}
