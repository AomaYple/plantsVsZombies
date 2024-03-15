import QtQml

SuspendableTimer {
    readonly property var basicZombieComponent: Qt.createComponent('../zombies/BasicZombie.qml', Component.Asynchronous)
    readonly property var zombieComponent: basicZombieComponent
    readonly property var zombieContainer: [new Set(), new Set(), new Set(), new Set(), new Set(), new Set(),]

    interval: 5000
    repeat: true
}
