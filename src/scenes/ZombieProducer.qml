import QtQuick

SuspendableTimer {
    readonly property var basicZombieComponent: Qt.createComponent(rootPath + '/src/zombies/BasicZombie.qml', Component.Asynchronous)
    property var zombieComponent: basicZombieComponent
    property var zombieContainer: [[], [], [], [], [], []]

    interval: 5000
    repeat: true
}
