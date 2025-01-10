import QtQuick
import QtMultimedia

Image {
    id: image

    signal finished

    function start() {
        source = '../../res/scenes/startReady.png';
    }

    asynchronous: true
    mipmap: true
    sourceSize: Qt.size(width, height)
    width: height / 99 * 210

    onStatusChanged: if (status === Image.Ready) {
        if (source.toString() !== '../../res/scenes/startPlant.png')
            scaleAnimator.start();
        timer.start();
        soundEffect.play();
    }

    Timer {
        id: timer

        interval: 700

        onTriggered: {
            if (parent.source.toString() === '../../res/scenes/startReady.png') {
                scaleAnimator.stop();
                parent.source = '../../res/scenes/startSet.png';
                start();
            } else if (parent.source.toString() === '../../res/scenes/startSet.png') {
                scaleAnimator.stop();
                parent.source = '../../res/scenes/startPlant.png';
                start();
            } else {
                parent.source = '';
                parent.visible = false;
                parent.finished();
            }
        }
    }

    ScaleAnimator {
        id: scaleAnimator

        duration: 300
        target: image
        to: 1.3

        onStopped: target.scale = 1
    }

    SoundEffect {
        id: soundEffect

        source: '../../res/sounds/readySetPlant.wav'
    }
}
