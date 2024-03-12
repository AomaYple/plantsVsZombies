import QtQuick
import "../scenes" as Scenes

Plant {
    readonly property var peaComponent: Qt.createComponent(rootPath + '/src/plants/Pea.qml', Component.Asynchronous)
    property bool zombieAppeared: false

    signal peaShot(point position)

    lifeValue: 5
    source: rootPath + '/resources/plants/peaShooter' + (zombieAppeared ? 'Shooting.gif' : '.gif')
    type: PlantType.Type.PeaShooter

    onCurrentFrameChanged: currentFrame => {
        if (zombieAppeared && currentFrame === 12)
            peaShot(Qt.point(x + width, y + height * 0.12));
    }

    Scenes.Shadow {
        height: parent.height * 0.52
        x: parent.width * 0.07
        y: parent.height * 0.55
    }
}
