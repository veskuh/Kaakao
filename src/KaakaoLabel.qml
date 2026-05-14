import QtQuick
import QtQuick.Controls.Basic

/*!
    \qmltype KaakaoLabel
    \inqmlmodule Kaakao
    \brief A text label with predefined semantic roles.
    \inherits QtQuick.Controls.Label

    KaakaoLabel provides a set of semantic roles that automatically apply the
    correct font size, weight, and opacity according to classic macOS design patterns.
*/
Label {
    id: control

    /*!
        \qmlproperty enumeration KaakaoLabel::role
        Defines the semantic role of the label, which determines its visual styling.
        The following roles are supported:
        \list
            \li \b {KaakaoLabel.Role.Primary}: The default role for standard UI text.
            \li \b {KaakaoLabel.Role.Secondary}: Used for descriptive or less important text (70% opacity).
            \li \b {KaakaoLabel.Role.Small}: Used for captions or compact details (11px, 70% opacity).
            \li \b {KaakaoLabel.Role.Header}: Used for section headings (15px, Bold).
        \endlist
    */
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

    // Classic macOS labels often have a very subtle shadow or sharp rendering.
    // but for standard labels, color and sizing are the primary spec.
}
