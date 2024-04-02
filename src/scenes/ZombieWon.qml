import QtQuick
import QtMultimedia

Image {
    id: image

    signal zombieWon

    function start() {
        source = '../../resources/scenes/zombieWon.png';
    }

    asynchronous: true
    mipmap: true
    scale: 0
    sourceSize: Qt.size(width, height)
    visible: false
    width: height / 380 * 513

    onStatusChanged: if (status === Image.Ready) {
        visible = true;
        scaleAnimator.start();
        scream.play();
    }

    ScaleAnimator {
        id: scaleAnimator

        duration: 1000
        target: image
        to: 1
    }

    SoundEffect {
        id: scream

        source: '../../resources/sounds/scream.wav'

        onPlayingChanged: if (!playing)
            image.zombieWon()
    }
}
