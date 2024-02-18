import QtQuick
import QtMultimedia

Item {
    id: root

    signal adventureStarted
    signal quitted

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
            source: startAdventureMouseArea.containsMouse ? '../../resources/images/startAdventureHighlight.png' : '../../resources/images/startAdventure.png'
            sourceSize: Qt.size(width, height)
            width: height / 584 * 1324
            x: parent.width * 0.5
            y: parent.height * 0.1

            MouseArea {
                id: startAdventureMouseArea

                anchors.fill: parent
                cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                hoverEnabled: enabled

                onClicked: {
                    enabled = false;
                    quitMouseArea.enabled = false;
                    evilLaughSound.play();
                    startAdventureTimer.start();
                    zomebieHandTimer.start();
                }
                onEntered: bleepSound.play()
            }
            MediaPlayer {
                id: evilLaughSound

                source: '../../resources/sounds/evilLaugh.flac'

                audioOutput: AudioOutput {
                }

                onPlaybackStateChanged: if (playbackState === MediaPlayer.StoppedState)
                    root.adventureStarted()
            }
            Timer {
                id: startAdventureTimer

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
            width: height
            x: parent.width * 0.2
            y: parent.height * 0.45

            Timer {
                id: zomebieHandTimer

                property int zombineHandNumber: 1

                interval: 60
                repeat: true

                onTriggered: if (zombineHandNumber < 8)
                    parent.source = '../../resources/images/zombieHand' + zombineHandNumber++ + '.png'
            }
        }
        Image {
            asynchronous: true
            height: parent.height * 0.04
            mipmap: true
            source: quitMouseArea.containsMouse ? '../../resources/images/quitHighlight.png' : '../../resources/images/quit.png'
            sourceSize: Qt.size(width, height)
            width: height / 108 * 188
            x: parent.width * 0.905
            y: parent.height * 0.86

            MouseArea {
                id: quitMouseArea

                anchors.fill: parent
                cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                hoverEnabled: enabled

                onClicked: root.quitted()
                onEntered: bleepSound.play()
            }
        }
        MediaPlayer {
            id: bleepSound

            source: '../../resources/sounds/bleep.wav'

            audioOutput: AudioOutput {
            }
        }
    }
}