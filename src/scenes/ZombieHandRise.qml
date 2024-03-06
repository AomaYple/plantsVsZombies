import QtQuick
import QtMultimedia

AnimatedImage {
    id: root

    signal rose

    function rise() {
        source = '../../resources/scenes/zombieHandRise.gif';
        soundEffect.play();
    }

    asynchronous: true
    height: parent.height * 0.5
    mipmap: true
    sourceSize: Qt.size(width, height)
    speed: 2
    width: height / 315 * 230
    x: parent.width * 0.25
    y: parent.height * 0.47

    onCurrentFrameChanged: if (currentFrame === frameCount - 1)
        playing = false

    SoundEffect {
        id: soundEffect

        source: '../../resources/sounds/evilLaugh.wav'

        onPlayingChanged: if (!playing)
            root.rose()
    }
}

