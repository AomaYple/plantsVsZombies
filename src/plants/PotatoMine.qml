import QtQuick
import "../scenes" as Scenes

Plant {
    property bool ready: false

    signal exploded

    function explode() {
        die();
        exploded();
    }

    lifeValue: 5
    shadowHeight: height * 0.6
    shadowPosition: Qt.point(width * 0.07, height * 0.55)
    type: PlantType.Type.PotatoMine

    onCurrentFrameChanged: (currentFrame, frameCount) => {
        if (source.toString() === '../../res/plants/risingPotatoMine.gif' && currentFrame === frameCount - 1)
            source = '../../res/plants/potatoMine.gif';
    }

    Image {
        id: image

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: '../../res/plants/initializingPotatoMine.png'
        sourceSize: Qt.size(width, height)
    }

    Scenes.SuspendableTimer {
        interval: 15000
        paused: parent.paused
        running: true

        onTriggered: {
            image.source = '';
            parent.source = '../../res/plants/risingPotatoMine.gif';
            parent.ready = true;
        }
    }
}
