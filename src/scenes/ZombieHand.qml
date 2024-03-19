import QtQuick
import QtMultimedia

AnimatedImage {
    id: animatedImage

    signal rose

    function rise() {
        source = '../../resources/scenes/risingZombieHand.gif';
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

        source: '../../resources/sounds/evilLaugh.wav'

        onPlayingChanged: if (!playing)
            animatedImage.rose()
    }
}
