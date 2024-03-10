import QtQuick
import QtMultimedia

Image {
    property bool shoveling: true

    signal clicked

    asynchronous: true
    mipmap: true
    source: rootPath + '/resources/scenes/shovelBank.png'
    sourceSize: Qt.size(width, height)
    visible: false
    width: height / 72 * 70
    y: 0

    MouseArea {
        anchors.fill: parent
        cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
        enabled: parent.enabled

        onClicked: {
            soundEffect.play();
            parent.clicked();
        }
    }
    SoundEffect {
        id: soundEffect

        source: rootPath + '/resources/sounds/shovel.wav'
    }
}
