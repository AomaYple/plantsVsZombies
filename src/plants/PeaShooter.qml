import QtQml
import "../scenes" as Scenes

Plant {
    readonly property var peaComponent: Qt.createComponent('Pea.qml', Component.Asynchronous)
    property int zombieCount: 0

    signal peaShot(point position)

    lifeValue: 5
    shadowHeight: height * 0.52
    shadowPosition: Qt.point(width * 0.07, height * 0.55)
    source: '../../resources/plants/peaShooter' + (zombieCount > 0 ? 'Shooting.gif' : '.gif')
    type: PlantType.Type.PeaShooter

    Scenes.SuspendableTimer {
        interval: 800
        paused: parent.paused
        repeat: true
        running: parent.zombieCount > 0

        onTriggered: parent.peaShot(Qt.point(parent.x + parent.width, parent.y + parent.height * 0.12))
    }
}
