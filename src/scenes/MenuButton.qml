import QtQuick
import QtMultimedia

Image {
    signal triggered

    function trigger() {
        soundEffect.play();
        triggered();
    }

    asynchronous: true
    mipmap: true
    source: '../../resources/scenes/button.png'
    sourceSize: Qt.size(width, height)
    visible: false
    width: height / 109 * 291

    Keys.onEscapePressed: trigger()

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

        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: parent.trigger()
    }

    SoundEffect {
        id: soundEffect

        source: '../../resources/sounds/pause.wav'
    }
}
