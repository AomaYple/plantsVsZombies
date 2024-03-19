import QtQuick
import QtMultimedia

Image {
    id: image

    signal finished

    function start() {
        source = '../../resources/scenes/startReady.png';
        soundEffect.play();
    }

    asynchronous: true
    mipmap: true
    sourceSize: Qt.size(width, height)
    width: height / 99 * 210

    onStatusChanged: if (status === Image.Ready) {
        if (source.toString() !== '../../resources/scenes/startPlant.png')
            scaleAnimator.start();
        timer.start();
    }

    Timer {
        id: timer

        interval: 700

        onTriggered: {
            if (parent.source.toString() === '../../resources/scenes/startReady.png') {
                scaleAnimator.stop();
                parent.source = '../../resources/scenes/startSet.png';
                start();
            } else if (parent.source.toString() === '../../resources/scenes/startSet.png') {
                scaleAnimator.stop();
                parent.source = '../../resources/scenes/startPlant.png';
                start();
            } else {
                parent.source = '';
                parent.finished();
            }
        }
    }

    ScaleAnimator {
        id: scaleAnimator

        duration: 300
        target: image
        to: 1.3

        onStopped: image.scale = 1
    }

    SoundEffect {
        id: soundEffect

        source: '../../resources/sounds/readySetPlant.wav'
    }
}
