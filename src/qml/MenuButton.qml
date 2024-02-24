import QtQuick
import QtMultimedia

Item {
    id: root

    signal triggered

    Keys.onEscapePressed: triggered()
    onTriggered: pause.play()

    Image {
        id: menuButton

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
            cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
            enabled: root.enabled

            onClicked: root.triggered()
        }
    }
    MediaPlayer {
        id: pause

        source: '../../resources/sounds/pause.flac'

        audioOutput: AudioOutput {
        }
    }
}
