import QtQuick
import "../scenes" as Scenes

Item {
    readonly property int lifeValue: 300
    property alias paused: animatedImage.paused
    readonly property var peaComponent: Qt.createComponent(rootPath + '/src/plants/Pea.qml', Component.Asynchronous)
    required property bool shoveling
    readonly property int type: PlantType.Type.PeaShooter
    property bool zombieAppeared: false

    signal peaShot(point position)

    width: height

    Scenes.Shadow {
        height: parent.height * 0.45
        x: parent.width * 0.08
        y: parent.height * 0.6
    }
    AnimatedImage {
        id: animatedImage

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        opacity: parent.shoveling ? 0.8 : 1
        source: rootPath + '/resources/plants/peaShooter' + (zombieAppeared ? 'Shooting.gif' : '.gif')
        sourceSize: Qt.size(width, height)

        onCurrentFrameChanged: if (currentFrame === 12)
            parent.peaShot(Qt.point(parent.x + parent.width, parent.y + parent.height * 0.12))
    }
}
