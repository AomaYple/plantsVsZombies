import QtQuick
import QtMultimedia

Item {
    id: root

    signal clicked

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: '../../resources/scenes/shovelBank.png'
        sourceSize: Qt.size(width, height)

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                shovel.play();
                root.clicked();
            }

            SoundEffect {
                id: shovel

                source: '../../resources/sounds/shovel.wav'
            }
        }
    }
}
