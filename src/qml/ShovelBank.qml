import QtQuick
import QtMultimedia

Item {
    id: root

    signal clicked

    Image {
        anchors.fill: parent
        mipmap: true
        source: '../../resources/scenes/shovelBank.png'
        sourceSize: Qt.size(width, height)

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                sound.play();
                root.clicked();
            }

            SoundEffect {
                id: sound

                source: '../../resources/sounds/shovel.wav'
            }
        }
    }
}
