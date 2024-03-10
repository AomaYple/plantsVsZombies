import QtQuick
import QtMultimedia

Image {
    id: root

    signal finished

    function start() {
        source = rootPath + '/resources/scenes/startReady.png';
        soundEffect.play();
    }

    asynchronous: true
    mipmap: true
    sourceSize: Qt.size(width, height)
    width: height / 99 * 210

    onStatusChanged: if (status === Image.Ready) {
        if (source.toString() !== rootPath + '/resources/scenes/startPlant.png')
            scaleAnimator.start();
        timer.start();
    }

    Timer {
        id: timer

        interval: 700

        onTriggered: {
            if (parent.source.toString() === rootPath + '/resources/scenes/startReady.png') {
                scaleAnimator.stop();
                parent.source = rootPath + '/resources/scenes/startSet.png';
                start();
            } else if (parent.source.toString() === rootPath + '/resources/scenes/startSet.png') {
                scaleAnimator.stop();
                parent.source = rootPath + '/resources/scenes/startPlant.png';
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
        target: root
        to: 1.3

        onStopped: root.scale = 1
    }
    SoundEffect {
        id: soundEffect

        source: rootPath + '/resources/sounds/readySetPlant.wav'
    }
}
