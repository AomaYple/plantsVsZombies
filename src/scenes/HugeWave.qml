import QtQuick
import QtMultimedia

Image {
    id: image

    required property bool paused

    function play() {
        source = '../../res/scenes/hugeWave.png';
    }

    function stop() {
        source = '';
        visible = false;
        numberAnimation.stop();
        suspendableTimer.stop();
        hugeWave.stop();
    }

    asynchronous: true
    mipmap: true
    scale: 3
    sourceSize: Qt.size(width, height)
    visible: false
    width: height / 58 * 471

    onStatusChanged: if (status === Image.Ready) {
        visible = true;
        numberAnimation.start();
        hugeWave.play();
    }

    NumberAnimation {
        id: numberAnimation

        paused: running && target.paused
        properties: 'scale'
        target: image
        to: 1

        onFinished: suspendableTimer.start()
    }

    SuspendableTimer {
        id: suspendableTimer

        interval: 3000
        paused: parent.paused

        onTriggered: {
            parent.visible = false;
            parent.source = '';
        }
    }

    SoundEffect {
        id: hugeWave

        source: '../../res/sounds/hugeWave.wav'

        onPlayingChanged: if (!playing)
            siren.play()
    }

    SoundEffect {
        id: siren

        source: '../../res/sounds/siren.wav'
    }
}
