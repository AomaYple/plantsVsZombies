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
            width: height / sourceSize.height * sourceSize.width
            x: parent.width * 0.5
            y: parent.height * 0.1

            onStatusChanged: if (status === Image.Ready) {
                const aspectRatio = sourceSize.width / sourceSize.height;
                sourceSize = Qt.size(height * aspectRatio, height);
            }

            MouseArea {
                id: startAdventureMouseArea

                anchors.fill: parent
                cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                enabled: hoverEnabled
                hoverEnabled: true

                onClicked: {
                    hoverEnabled = false;
                    quitMouseArea.hoverEnabled = false;
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
            width: height / sourceSize.height * sourceSize.width
            x: parent.width * 0.2
            y: parent.height * 0.45

            onStatusChanged: if (status === Image.Ready) {
                const aspectRatio = sourceSize.width / sourceSize.height;
                sourceSize = Qt.size(height * aspectRatio, height);
            }

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
            width: height / sourceSize.height * sourceSize.width
            x: parent.width * 0.905
            y: parent.height * 0.86

            onStatusChanged: if (status === Image.Ready) {
                const aspectRatio = sourceSize.width / sourceSize.height;
                sourceSize = Qt.size(height * aspectRatio, height);
            }

            MouseArea {
                id: quitMouseArea

                anchors.fill: parent
                cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                enabled: hoverEnabled
                hoverEnabled: true

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