import Caelestia.Plugins

SettingsObject {
    property string defaultMode: "extend"
    SettingMeta on defaultMode {
        label: "Default display mode"
        description: "Extend creates a separate workspace. Duplicate mirrors the laptop display."
        icon: "display_settings"
        inputType: SettingMeta.SplitButton
        options: ["extend", "duplicate"]
        optionIcons: ["view_week", "content_copy"]
    }

    property string resolution: "1920x1080"
    SettingMeta on resolution {
        label: "Client resolution"
        description: "Lower resolutions reduce latency; choose an aspect ratio that fits the receiving display."
        icon: "aspect_ratio"
        inputType: SettingMeta.SplitButton
        options: ["1920x1080", "1600x1200", "1920x1440", "2160x1620"]
    }

    property int refreshRate: 60
    SettingMeta on refreshRate {
        label: "Refresh rate"
        description: "Frames per second requested from Hyprland."
        icon: "60fps"
        inputType: SettingMeta.SpinBox
        min: 30
        max: 120
        step: 10
    }

    property real scale: 1
    SettingMeta on scale {
        label: "Display scale"
        description: "Logical scaling for the headless output."
        icon: "zoom_in"
        inputType: SettingMeta.SpinBox
        min: 0.5
        max: 3
        step: 0.25
    }

    property string position: "right"
    SettingMeta on position {
        label: "Extended-display position"
        description: "Where the remote display sits relative to the primary display."
        icon: "open_in_new"
        inputType: SettingMeta.SplitButton
        options: ["right", "left", "above", "below", "auto"]
    }

    property bool stopWeylusOnDisconnect: true
    SettingMeta on stopWeylusOnDisconnect {
        label: "Stop Weylus on disconnect"
        description: "Leaves no streaming process running after the companion display is switched off."
        icon: "power_settings_new"
        inputType: SettingMeta.Switch
    }
}
