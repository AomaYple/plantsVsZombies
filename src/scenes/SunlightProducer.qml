import QtQml

SuspendableTimer {
    readonly property Component sunlightComponent: Qt.createComponent('Sunlight.qml', Component.Asynchronous)

    interval: 6500
    repeat: true
}
