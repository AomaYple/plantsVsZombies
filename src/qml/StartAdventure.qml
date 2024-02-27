import QtQuick
import QtMultimedia

Item {
    id: root

    signal adventured
    signal clicked
    signal entered

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: mouseArea.containsMouse ? '../../resources/images/startAdventureHighlight.png' : '../../resources/images/startAdventure.png'
        sourceSize: Qt.size(width, height)

        MouseArea {
            id: mouseArea

            anchors.fill: parent
            cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
            enabled: root.enabled
            hoverEnabled: enabled

            onClicked: {
                twinkle.start();
                evilLaugh.play();
                root.clicked();
            }
            onEntered: root.entered()
        }
        Timer {
            id: twinkle

            interval: 100
            repeat: true

            onTriggered: {
                if (parent.source.toString() === '../../resources/images/startAdventure.png')
                    parent.source = '../../resources/images/startAdventureHighlight.png';
                else
                    parent.source = '../../resources/images/startAdventure.png';
            }
        }
        MediaPlayer {
            id: evilLaugh

            source: '../../resources/sounds/evilLaugh.flac'

            audioOutput: AudioOutput {
            }

            onPlaybackStateChanged: if (playbackState === MediaPlayer.StoppedState)
                root.adventured()
        }
    }
}
