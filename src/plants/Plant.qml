import QtQuick
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

    signal currentFrameChanged(int currentFrame, int frameCount)
    signal died
    signal shovelled

    function die() {
        destroy();
        died();
    }

    function shovel() {
        destroy();
        shovelled();
    }

    function twinkle() {
        numberAnimation.start();
    }

    opacity: shoveling ? 0.8 : 1
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
        sourceSize: Qt.size(width, height)

        onCurrentFrameChanged: parent.currentFrameChanged(currentFrame, frameCount)
    }

    NumberAnimation {
        id: numberAnimation

        duration: 250
        paused: running && target.paused
        properties: 'opacity'
        target: item
        to: 0.5

        onFinished: if (to === 0.5) {
            to = 1;
            start();
        } else {
            to = 0.5;
            target.opacity = Qt.binding(function () {
                return target.shoveling ? 0.8 : 1;
            });
        }
    }
}
