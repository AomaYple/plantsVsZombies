import QtQuick
import QtMultimedia

Item {
    id: root

    signal rose

    function rise() {
        rise.start();
        evilLaughSound.play();
    }

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        sourceSize: Qt.size(width, height)

        Timer {
            id: rise

            property int index: 1

            interval: 70
            repeat: true

            onTriggered: if (index < 8)
                parent.source = '../../resources/scenes/zombieHand' + index++ + '.png'
        }

        SoundEffect {
            id: evilLaughSound

            source: '../../resources/sounds/evilLaugh.wav'

            onPlayingChanged: if (!playing)
                root.rose()
        }
    }
}
