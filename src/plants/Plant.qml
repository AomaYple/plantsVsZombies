import QtQuick
import QtMultimedia

Item {
    required property int lifeValue
    property alias paused: animatedImage.paused
    required property bool shoveling
    property alias source: animatedImage.source
    required property int type

    signal currentFrameChanged(int currentFrame)
    signal died

    function die() {
        destroy();
        soundEffect.play();
        died();
    }
    function shovel() {
        destroy();
        died();
    }
    function twinkle() {
        numberAnimation.start();
    }

    width: height

    onLifeValueChanged: if (lifeValue <= 0)
        die()

    AnimatedImage {
        id: animatedImage

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        opacity: parent.shoveling ? 0.8 : 1
        sourceSize: Qt.size(width, height)
        z: 1

        onCurrentFrameChanged: parent.currentFrameChanged(currentFrame)
    }
    NumberAnimation {
        id: numberAnimation

        duration: 250
        paused: running && parent.paused
        properties: 'opacity'
        target: animatedImage
        to: 0.5

        onFinished: if (to === 0.5) {
            to = 1;
            start();
        } else {
            to = 0.5;
            animatedImage.opacity = Qt.binding(function () {
                return root.shoveling ? 0.8 : 1;
            });
        }
    }
    SoundEffect {
        id: soundEffect

        source: rootPath + '/resources/sounds/gulp.wav'
    }
}
