import QtQuick
import QtMultimedia

Item {
    id: root

    property alias source: menuButton.source

    signal clicked
    signal triggered

    enabled: false
    focus: enabled

    Keys.onEscapePressed: {
        pause.play();
        root.triggered();
    }

    Image {
        id: menuButton

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        sourceSize: Qt.size(width, height)

        onStatusChanged: if (status === Image.Ready)
            emerge.start()

        Text {
            id: text

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

            onClicked: {
                pause.play();
                root.clicked();
            }
        }
    }
    YAnimator {
        id: emerge

        duration: 500
        target: root
        to: -root.height * 0.1
    }
    MediaPlayer {
        id: pause

        source: '../../resources/sounds/pause.flac'

        audioOutput: AudioOutput {
        }
    }
}
