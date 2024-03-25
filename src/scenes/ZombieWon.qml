import QtQuick
import QtMultimedia

Image {
    id: image

    signal zombieWon

    function start() {
        visible = true;
        source = '../../resources/scenes/zombieWon.png';
        scream.play();
    }

    asynchronous: true
    mipmap: true
    scale: 0
    sourceSize: Qt.size(width, height)
    visible: false
    width: height / 380 * 513

    onStatusChanged: if (status === Image.Ready)
        scaleAnimator.start()

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
