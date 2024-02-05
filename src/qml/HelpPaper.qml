import QtQuick
import QtQuick.Controls
import QtMultimedia

Item {
    id: root

    signal clickedMainMenuButton

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: '../../resources/images/helpPaper.png'

        Component.onCompleted: {
            helpPaperSound.play();
        }

        Button {
            height: width * (mainMenuButtonBackground.sourceSize.height / mainMenuButtonBackground.sourceSize.width)
            width: parent.width * 0.1
            x: parent.width * 0.45
            y: parent.height * 0.9

            background: Image {
                id: mainMenuButtonBackground

                asynchronous: true
                mipmap: true
                source: '../../resources/images/mainMenuButton.png'
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: root.clickedMainMenuButton()
            }
        }
        MediaPlayer {
            id: helpPaperSound

            source: '../../resources/music/paper.flac'

            audioOutput: AudioOutput {
            }
        }
    }
}
