import QtQuick
import QtMultimedia

Item {
    id: root

    signal finished

    function start() {
        image.source = rootPath + '/resources/scenes/startReady.png';
        soundEffect.play();
    }

    width: height / 99 * 210

    Image {
        id: image

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        sourceSize: Qt.size(width, height)

        onStatusChanged: if (status === Image.Ready) {
            if (source.toString() !== rootPath + '/resources/scenes/startPlant.png')
                scaleAnimator.start();
            timer.start();
        }
    }
    Timer {
        id: timer

        interval: 700

        onTriggered: {
            if (image.source.toString() === rootPath + '/resources/scenes/startReady.png') {
                scaleAnimator.stop();
                image.source = rootPath + '/resources/scenes/startSet.png';
                start();
            } else if (image.source.toString() === rootPath + '/resources/scenes/startSet.png') {
                scaleAnimator.stop();
                image.source = rootPath + '/resources/scenes/startPlant.png';
                start();
            } else {
                image.source = '';
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
