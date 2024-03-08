import QtQuick
import QtMultimedia

Image {
    signal triggered

    asynchronous: true
    mipmap: true
    source: rootPath + '/resources/scenes/button.png'
    sourceSize: Qt.size(width, height)
    visible: false
    width: height / 109 * 291
    y: 0

    Keys.onEscapePressed: mouseArea.trigger()

    Text {
        anchors.centerIn: parent
        color: '#008000'
        text: '菜单'

        font {
            bold: true
            pointSize: Math.max(parent.height * 0.3, 1)
        }
    }
    MouseArea {
        id: mouseArea

        function trigger() {
            soundEffect.play();
            parent.triggered();
        }

        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: trigger()

        SoundEffect {
            id: soundEffect

            source: rootPath + '/resources/sounds/pause.wav'
        }
    }
}
