import QtQuick
import QtMultimedia

Item {
    id: root

    signal clickedMainMenuButton

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: '../../resources/images/helpPaper.png'

        Component.onCompleted: helpPaperSound.play()

        Image {
            asynchronous: true
            height: width * (sourceSize.height / sourceSize.width)
            mipmap: true
            source: '../../resources/images/mainMenuButton.png'
            width: parent.width * 0.1
            x: parent.width * 0.45
            y: parent.height * 0.9

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: root.clickedMainMenuButton()
            }
        }
        MediaPlayer {
            id: helpPaperSound

            source: '../../resources/sound/paper.flac'

            audioOutput: AudioOutput {
            }
        }
    }
}
