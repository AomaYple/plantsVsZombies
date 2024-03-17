import QtQuick
import QtMultimedia

Image {
    id: image

    asynchronous: true
    mipmap: true
    source: '../../resources/plants/mashedPotato.png'
    sourceSize: Qt.size(width, height)

    SoundEffect {
        source: '../../resources/sounds/potatoMine.wav'

        Component.onCompleted: play()
        onPlayingChanged: if (!playing)
            image.destroy()
    }
}
