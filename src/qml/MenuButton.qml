import QtQuick
import QtMultimedia

Item {
    id: root

    signal triggered

    Keys.onEscapePressed: triggered()
    onTriggered: pauseSound.play()

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: '../../resources/images/button.png'
        sourceSize: Qt.size(width, height)

        Text {
            anchors.centerIn: parent
            color: '#008000'
            text: '菜单'

            font {
                bold: true
                pointSize: height > 0 ? height * 12 : 1
            }
        }
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: root.triggered()
        }
    }
    MediaPlayer {
        id: pauseSound

        source: '../../resources/sounds/pause.flac'

        audioOutput: AudioOutput {
        }
    }
}
