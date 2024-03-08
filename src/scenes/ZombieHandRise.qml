import QtQuick
import QtMultimedia

AnimatedImage {
    id: root

    signal rose

    function rise() {
        source = rootPath + '/resources/scenes/zombieHandRise.gif';
        soundEffect.play();
    }

    asynchronous: true
    mipmap: true
    sourceSize: Qt.size(width, height)
    speed: 2
    width: height / 315 * 230

    onCurrentFrameChanged: if (currentFrame === frameCount - 1)
        playing = false

    SoundEffect {
        id: soundEffect

        source: rootPath + '/resources/sounds/evilLaugh.wav'

        onPlayingChanged: if (!playing)
            root.rose()
    }
}

