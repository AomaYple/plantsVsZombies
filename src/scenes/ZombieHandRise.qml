import QtQuick
import QtMultimedia

Item {
    signal rose

    function rise() {
        animatedImage.source = rootPath + '/resources/scenes/zombieHandRise.gif';
        soundEffect.play();
    }

    width: height / 315 * 230

    AnimatedImage {
        id: animatedImage

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        sourceSize: Qt.size(width, height)

        onCurrentFrameChanged: if (currentFrame === frameCount - 1)
            playing = false
    }
    SoundEffect {
        id: soundEffect

        source: rootPath + '/resources/sounds/evilLaugh.wav'

        onPlayingChanged: if (!playing)
            parent.rose()
    }
}

