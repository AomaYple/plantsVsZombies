import QtQuick
import QtMultimedia

AnimatedImage {
    id: root

    signal rose

    function rise() {
        source = Qt.binding(function () {
            return rootPath + '/resources/scenes/zombieHandRise.gif';
        });
        soundEffect.play();
    }

    asynchronous: true
    mipmap: true
    sourceSize: Qt.size(width, height)
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

