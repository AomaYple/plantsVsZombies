import QtQuick

SuspendableTimer {
    readonly property var basicZombieComponent: Qt.createComponent(rootPath + '/src/zombies/BasicZombie.qml', Component.Asynchronous)
    readonly property var zombieComponent: basicZombieComponent
    readonly property var zombieContainer: [Set(), Set(), Set(), Set(), Set(), Set(),]

    interval: 5000
    repeat: true
}
