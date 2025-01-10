import QtQuick
import QtMultimedia

AnimatedImage {
    id: animatedImage

    signal emerged

    function emerge(positionX) {
        xAnimator.to = positionX;
        source = '../../res/scenes/cart.gif';
    }

    function march(endPositionX) {
        if (paused) {
            paused = false;
            numberAnimation.to = endPositionX;
            numberAnimation.start();
            soundEffect.play();
        }
    }

    asynchronous: true
    mipmap: true
    paused: true
    sourceSize: Qt.size(width, height)
    visible: false

    onStatusChanged: if (status === Image.Ready) {
        visible = true;
        xAnimator.start();
    }

    XAnimator {
        id: xAnimator

        duration: 100
        target: animatedImage

        onFinished: target.emerged()
    }

    NumberAnimation {
        id: numberAnimation

        duration: 3000
        paused: running && target.paused
        properties: 'x'
        target: animatedImage

        onFinished: animatedImage.destroy()
    }

    SoundEffect {
        id: soundEffect

        source: '../../res/sounds/lawnMower.wav'
    }
}
