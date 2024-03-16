import QtQuick
import QtMultimedia
import "../scenes" as Scenes

Item {
    id: item

    required property int lifeValue
    property alias paused: animatedImage.paused
    property alias shadowHeight: shadow.height
    required property point shadowPosition
    readonly property alias shadowWidth: shadow.width
    required property bool shoveling
    property alias source: animatedImage.source
    required property int type

    signal currentFrameChanged(int currentFrame)
    signal died

    function die() {
        destroy();
        died();
    }

    function twinkle() {
        numberAnimation.running = true;
    }

    width: height

    onLifeValueChanged: if (lifeValue <= 0)
        die()

    Scenes.Shadow {
        id: shadow

        x: parent.shadowPosition.x
        y: parent.shadowPosition.y
    }

    AnimatedImage {
        id: animatedImage

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        opacity: parent.shoveling ? 0.8 : 1
        sourceSize: Qt.size(width, height)

        onCurrentFrameChanged: parent.currentFrameChanged(currentFrame)
    }

    NumberAnimation {
        id: numberAnimation

        duration: 250
        paused: running && item.paused
        properties: 'opacity'
        target: animatedImage
        to: 0.5

        onFinished: if (to === 0.5) {
            to = 1;
            running = true;
        } else {
            to = 0.5;
            item.opacity = Qt.binding(function () {
                return item.shoveling ? 0.8 : 1;
            });
        }
    }
}
