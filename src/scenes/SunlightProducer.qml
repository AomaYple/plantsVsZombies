import QtQml

SuspendableTimer {
    readonly property var sunlightComponent: Qt.createComponent('Sunlight.qml', Component.Asynchronous)

    interval: 6500
    repeat: true
}
