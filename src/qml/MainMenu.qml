import QtQuick
import QtMultimedia

Item {
    id: root

    signal adventured
    signal quit

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: '../../resources/images/mainMenu.png'
        sourceSize: Qt.size(width, height)

        Image {
            asynchronous: true
            height: parent.height * 0.25
            mipmap: true
            source: startAdventureArea.containsMouse ? '../../resources/images/startAdventureHighlight.png' : '../../resources/images/startAdventure.png'
            sourceSize: Qt.size(width, height)
            width: height / 584 * 1324
            x: parent.width * 0.5
            y: parent.height * 0.1

            MouseArea {
                id: startAdventureArea

                anchors.fill: parent
                cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                hoverEnabled: enabled

                onClicked: {
                    enabled = false;
                    evilLaugh.play();
                    startAdventureTwinkle.start();
                    zomebieHandRoll.start();
                }
                onEntered: bleep.play()
            }
            MediaPlayer {
                id: evilLaugh

                source: '../../resources/sounds/evilLaugh.flac'

                audioOutput: AudioOutput {
                }

                onPlaybackStateChanged: if (playbackState === MediaPlayer.StoppedState)
                    root.adventured()
            }
            Timer {
                id: startAdventureTwinkle

                interval: 100
                repeat: true

                onTriggered: {
                    if (parent.source.toString() === '../../resources/images/startAdventure.png')
                        parent.source = '../../resources/images/startAdventureHighlight.png';
                    else
                        parent.source = '../../resources/images/startAdventure.png';
                }
            }
        }
        Image {
            asynchronous: true
            height: parent.height * 0.5
            mipmap: true
            sourceSize: Qt.size(width, height)
            width: height / 1254 * 820
            x: parent.width * 0.28
            y: parent.height * 0.48

            Timer {
                id: zomebieHandRoll

                property int index: 1

                interval: 60
                repeat: true

                onTriggered: if (index < 8)
                    parent.source = '../../resources/images/zombieHand' + index++ + '.png'
            }
        }
        Image {
            asynchronous: true
            height: parent.height * 0.04
            mipmap: true
            source: quitArea.containsMouse ? '../../resources/images/quitHighlight.png' : '../../resources/images/quit.png'
            sourceSize: Qt.size(width, height)
            width: height / 92 * 176
            x: parent.width * 0.903
            y: parent.height * 0.86

            MouseArea {
                id: quitArea

                anchors.fill: parent
                cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                enabled: startAdventureArea.enabled
                hoverEnabled: enabled

                onClicked: root.quit()
                onEntered: bleep.play()
            }
        }
        MediaPlayer {
            id: bleep

            source: '../../resources/sounds/bleep.wav'

            audioOutput: AudioOutput {
            }
        }
    }
}