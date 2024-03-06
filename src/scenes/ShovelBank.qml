import QtQuick
import QtMultimedia

Image {
    property bool shoveling: false

    signal clicked

    asynchronous: true
    height: parent.height * 0.13
    mipmap: true
    source: '../../resources/scenes/shovelBank.png'
    sourceSize: Qt.size(width, height)
    visible: false
    width: height / 72 * 70
    y: 0

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            soundEffect.play();
            parent.clicked();
        }

        SoundEffect {
            id: soundEffect

            source: '../../resources/sounds/shovel.wav'
        }
    }
}
