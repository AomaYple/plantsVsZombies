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
        if (source.toString() === '../../resources/plants/risingPotatoMine.gif' && currentFrame === frameCount - 1)
            source = '../../resources/plants/potatoMine.gif';
    }

    Image {
        id: image

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: '../../resources/plants/initializingPotatoMine.png'
        sourceSize: Qt.size(width, height)
    }

    Scenes.SuspendableTimer {
        interval: 15000
        paused: parent.paused
        running: true

        onTriggered: {
            image.source = '';
            parent.source = '../../resources/plants/risingPotatoMine.gif';
            parent.ready = true;
        }
    }
}
