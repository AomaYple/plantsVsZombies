import QtQuick
import QtMultimedia

Image {
    id: image

    required property bool paused

    function play() {
        visible = true;
        numberAnimation.start();
        hugeWave.play();
    }

    function stop() {
        visible = false;
        numberAnimation.stop();
        suspendableTimer.stop();
        hugeWave.stop();
    }

    asynchronous: true
    mipmap: true
    scale: 3
    source: '../../resources/scenes/hugeWave.png'
    sourceSize: Qt.size(width, height)
    visible: false
    width: height / 58 * 471

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
            parent.source = '';
            parent.visible = false;
        }
    }

    SoundEffect {
        id: hugeWave

        source: '../../resources/sounds/hugeWave.wav'

        onPlayingChanged: if (!playing)
            siren.play()
    }

    SoundEffect {
        id: siren

        source: '../../resources/sounds/siren.wav'
    }
}
