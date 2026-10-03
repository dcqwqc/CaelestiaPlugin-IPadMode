import QtQuick
import Caelestia.Config
import qs.components
import qs.services
import dcqwqc.ipadmode.services as IPad

// Native-sized quick toggle. When active it becomes two distinct rounded
// segments: large exterior corners, small adjoining corners.
StyledRect {
    id: root

    property bool fillWidth: true
    property bool shapeMorph: true
    property real shapeMorphExpansion: 0

    implicitWidth: implicitHeight
    implicitHeight: powerIcon.implicitHeight + Tokens.padding.small * 2
    visible: IPad.IPadMode.available
    enabled: !IPad.IPadMode.busy

    readonly property bool split: IPad.IPadMode.active
    readonly property real outerRadius: split
        ? Math.min(height / 2, Tokens.rounding.large)
        : Math.min(width, height) / 2 * Math.min(1, Tokens.rounding.scale)
    readonly property real innerRadius: Math.min(outerRadius, Tokens.rounding.extraSmall)
    readonly property real segmentGap: split ? Math.max(2, Math.round(Tokens.spacing.extraSmall / 2)) : 0
    readonly property real powerWidth: split ? Math.floor((width - segmentGap) / 2) : width

    readonly property color selectedColour: Colours.palette.m3primary
    readonly property color selectedOnColour: Colours.palette.m3onPrimary
    readonly property color inactiveColour: Colours.layer(Colours.palette.m3surfaceContainerHighest, 2)
    readonly property color inactiveOnColour: Colours.palette.m3onSurfaceVariant

    radius: outerRadius
    color: "transparent"

    StyledRect {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: root.powerWidth
        radius: 0
        topLeftRadius: root.outerRadius
        bottomLeftRadius: root.outerRadius
        topRightRadius: root.split ? root.innerRadius : root.outerRadius
        bottomRightRadius: root.split ? root.innerRadius : root.outerRadius
        color: root.split ? root.selectedColour : root.inactiveColour

        Behavior on color { CAnim {} }
    }

    StyledRect {
        visible: root.split
        anchors.left: powerAction.right
        anchors.leftMargin: root.segmentGap
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        radius: 0
        topLeftRadius: root.innerRadius
        bottomLeftRadius: root.innerRadius
        topRightRadius: root.outerRadius
        bottomRightRadius: root.outerRadius
        color: root.selectedColour
    }

    Item {
        id: powerAction

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: root.powerWidth

        StateLayer {
            id: powerLayer
            color: root.split ? root.selectedOnColour : root.inactiveOnColour
            disabled: !root.enabled
            rect.topLeftRadius: root.outerRadius
            rect.bottomLeftRadius: root.outerRadius
            rect.topRightRadius: root.split ? root.innerRadius : root.outerRadius
            rect.bottomRightRadius: root.split ? root.innerRadius : root.outerRadius
            onClicked: IPad.IPadMode.togglePower()
        }

        MaterialIcon {
            id: powerIcon
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 1
            text: root.split ? "power_settings_new" : "tablet_mac"
            color: root.split ? root.selectedOnColour : root.inactiveOnColour
            fill: root.split ? 1 : 0
            fontStyle: Tokens.font.icon.medium
        }
    }

    Item {
        id: modeAction

        visible: root.split
        anchors.left: powerAction.right
        anchors.leftMargin: root.segmentGap
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        StateLayer {
            id: modeLayer
            color: root.selectedOnColour
            disabled: !root.enabled
            rect.topLeftRadius: root.innerRadius
            rect.bottomLeftRadius: root.innerRadius
            rect.topRightRadius: root.outerRadius
            rect.bottomRightRadius: root.outerRadius
            onClicked: IPad.IPadMode.toggleMode()
        }

        MaterialIcon {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 1
            text: IPad.IPadMode.mode === "duplicate" ? "content_copy" : "desktop_windows"
            color: root.selectedOnColour
            fill: 1
            fontStyle: Tokens.font.icon.medium
        }
    }

    onVisibleChanged: if (visible)
        IPad.IPadMode.refresh()
}
