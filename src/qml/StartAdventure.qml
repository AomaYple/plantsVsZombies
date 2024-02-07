import QtQuick
import QtMultimedia

Item {
    id: root

    signal clicked
    signal entered
    signal soundEnded

    height: width * (startAdventure.sourceSize.height / startAdventure.sourceSize.width)

    Image {
        id: startAdventure

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: startAdventureMouseArea.containsMouse ? '../../resources/images/startAdventureHovered.png' : '../../resources/images/startAdventure.png'

        onStatusChanged: if (status === Image.Ready) {
            const aspectRatio = sourceSize.width / sourceSize.height;
            sourceSize = Qt.size(width, width / aspectRatio);
        }

        MouseArea {
            id: startAdventureMouseArea

            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true

            onClicked: {
                evilLaughSound.play();
                startAdventureTimer.interval = evilLaughSound.duration / 20;
                startAdventureTimer.running = true;
                root.enabled = false;
                hoverEnabled = false;
                root.clicked();
            }
            onEntered: root.entered()
        }
        MediaPlayer {
            id: evilLaughSound

            source: '../../resources/sound/evilLaugh.flac'

            audioOutput: AudioOutput {
            }

            onMediaStatusChanged: if (mediaStatus === MediaPlayer.EndOfMedia)
                root.soundEnded()
        }
        Timer {
            id: startAdventureTimer

            repeat: true

            onTriggered: {
                if (parent.source.toString() === '../../resources/images/startAdventureHovered.png')
                    parent.source = '../../resources/images/startAdventure.png';
                else
                    parent.source = '../../resources/images/startAdventureHovered.png';
            }
        }
    }
}