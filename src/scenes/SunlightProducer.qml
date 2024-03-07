import QtQuick

Timer {
    readonly property var sunlightComponent: Qt.createComponent('Sunlight.qml', Component.Asynchronous)

    signal collected

    interval: 6500
    repeat: true
    running: parent.enabled

    onTriggered: {
        const sunlight = sunlightComponent.createObject(parent);
        sunlight.down();
        sunlight.collected.connect(function () {
            collected();
        });
    }
}
