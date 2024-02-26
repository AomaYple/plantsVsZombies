import QtQuick
import QtMultimedia

Item {
    id: root

    signal clicked

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: '../../resources/images/shovelBank.png'
        sourceSize: Qt.size(width, height)

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                shovelSound.play();
                root.clicked();
            }

            MediaPlayer {
                id: shovelSound

                source: '../../resources/sounds/shovel.flac'

                audioOutput: AudioOutput {
                }
            }
        }
    }
}
