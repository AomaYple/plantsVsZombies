import QtQuick

SuspendableTimer {
    readonly property var basicZombieComponent: Qt.createComponent(rootPath + '/src/zombies/BasicZombie.qml', Component.Asynchronous)

    interval: 9000
    repeat: true
}
