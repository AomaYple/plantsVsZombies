import QtQuick
import QtMultimedia

Item {
    id: root

    signal rose

    function rise() {
        background.source = '../../resources/scenes/zombieHandRise.gif';
        evilLaughSound.play();
    }

    AnimatedImage {
        id: background

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        sourceSize: Qt.size(width, height)
        speed: 2

        onCurrentFrameChanged: if (currentFrame === frameCount - 1)
            playing = false

        SoundEffect {
            id: evilLaughSound

            source: '../../resources/sounds/evilLaugh.wav'

            onPlayingChanged: if (!playing)
                root.rose()
        }
    }
}
