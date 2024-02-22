import QtQuick
import QtMultimedia

Item {
    id: root

    property bool shoveling: false
    property alias source: shovelBank.source

    signal clicked

    Image {
        id: shovelBank

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        sourceSize: Qt.size(width, height)

        onStatusChanged: if (status === Image.Ready)
            emerge.start()

        MouseArea {
            id: mouseArea

            anchors.fill: parent
            cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
            enabled: root.enabled

            onClicked: {
                root.clicked();
                shovelSound.play();
            }

            MediaPlayer {
                id: shovelSound

                source: '../../resources/sounds/shovel.flac'

                audioOutput: AudioOutput {
                }
            }
        }
    }
    YAnimator {
        id: emerge

        duration: 500
        target: root
        to: 0
    }
}
