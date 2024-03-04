import QtQuick
import QtMultimedia

Item {
    id: root

    signal finished

    function start() {
        background.source = '../../resources/scenes/startReady.png';
        readySetPlantSound.play();
    }

    Image {
        id: background

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        sourceSize: Qt.size(width, height)

        onStatusChanged: if (status === Image.Ready) {
            if (source.toString() !== '../../resources/scenes/startPlant.png')
                enlarge.start();
            interval.start();
        }

        Timer {
            id: interval

            interval: 700

            onTriggered: {
                if (parent.source.toString() === '../../resources/scenes/startReady.png') {
                    enlarge.stop();
                    parent.source = '../../resources/scenes/startSet.png';
                    start();
                } else if (parent.source.toString() === '../../resources/scenes/startSet.png') {
                    enlarge.stop();
                    parent.source = '../../resources/scenes/startPlant.png';
                    start();
                } else {
                    parent.source = '';
                    root.finished();
                }
            }
        }

        ScaleAnimator {
            id: enlarge

            duration: 300
            target: background
            to: 1.3

            onStopped: background.scale = 1
        }

        SoundEffect {
            id: readySetPlantSound

            source: '../../resources/sounds/readySetPlant.wav'
        }
    }
}
