import QtQuick
import "../scenes" as Scenes

Plant {
    property bool ready: false

    lifeValue: 5
    shadowHeight: height * 0.6
    shadowPosition: Qt.point(width * 0.07, height * 0.55)
    type: PlantType.Type.PotatoMine

    onCurrentFrameChanged: (currentFrame, frameCount) => {
        if (source.toString() === '../../resources/plants/potatoMineUp.gif' && currentFrame === frameCount - 1)
            source = '../../resources/plants/potatoMine.gif';
    }

    Image {
        id: image

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: '../../resources/plants/potatoMineInitializing.png'
        sourceSize: Qt.size(width, height)
    }

    Scenes.SuspendableTimer {
        interval: 15000
        paused: parent.paused
        running: true

        onTriggered: {
            image.source = '';
            parent.source = '../../resources/plants/potatoMineUp.gif';
            parent.ready = true;
        }
    }
}
