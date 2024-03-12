import QtQuick

SuspendableTimer {
    readonly property var sunlightComponent: Qt.createComponent(rootPath + '/src/scenes/Sunlight.qml', Component.Asynchronous)

    interval: 6500
    repeat: true
}
