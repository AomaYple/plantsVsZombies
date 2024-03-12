import QtQuick

SuspendableTimer {
    readonly property var basicZombieComponent: Qt.createComponent(rootPath + '/src/zombies/BasicZombie.qml', Component.Asynchronous)
    property var zombieComponent
    property var zombieContainer: [[], [], [], [], [], []]

    interval: 1000
    repeat: true

    onTriggered: zombieComponent = basicZombieComponent
}
