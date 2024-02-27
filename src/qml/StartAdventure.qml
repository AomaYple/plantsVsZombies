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
        source: mouseArea.containsMouse ? '../../resources/scenes/startAdventureHighlight.png' : '../../resources/scenes/startAdventure.png'
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
                if (parent.source.toString() === '../../resources/scenes/startAdventure.png')
                    parent.source = '../../resources/scenes/startAdventureHighlight.png';
                else
                    parent.source = '../../resources/scenes/startAdventure.png';
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
