import QtQuick
import "../scenes" as Scenes

Plant {
    readonly property int lifeValue: 300
    property bool zombieAppeared: false

    signal peaShot(point position)

    source: rootPath + '/resources/plants/peaShooter' + (zombieAppeared ? 'Shooting.gif' : '.gif')
    type: PlantType.Type.PeaShooter

    Scenes.SuspendableTimer {
        interval: 1400
        paused: running && parent.paused
        repeat: true
        running: zombieAppeared

        onTriggered: parent.peaShot(Qt.point(parent.x + parent.width, parent.y))
    }
}
