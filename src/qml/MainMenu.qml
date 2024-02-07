import QtQuick
import QtMultimedia

Item {
    id: root

    signal adventureStarted
    signal quitted

    Loader {
        id: loader

        anchors.fill: parent
        asynchronous: true
        sourceComponent: mainMenuComponent

        Component {
            id: mainMenuComponent

            Image {
                id: mainMenu

                anchors.fill: parent
                asynchronous: true
                mipmap: true
                source: '../../resources/images/mainMenu.png'
                sourceSize: Qt.size(width, height)

                StartAdventure {
                    id: startAdventure

                    width: parent.width * 0.3
                    x: parent.width * 0.56
                    y: parent.height * 0.09

                    onClicked: {
                        mainMenu.enabled = false;
                        quitMouseArea.hoverEnabled = false;
                        helpMouseArea.hoverEnabled = false;
                        zombieTimer.running = true;
                    }
                    onEntered: bleepSound.play()
                    onSoundEnded: root.adventureStarted()
                }
                Image {
                    height: width * (sourceSize.height / sourceSize.width)
                    mipmap: true
                    width: parent.width * 0.3
                    x: parent.width * 0.25
                    y: parent.height * 0.45

                    onStatusChanged: if (status === Image.Ready) {
                        const aspectRatio = sourceSize.width / sourceSize.height;
                        sourceSize = Qt.size(width, width / aspectRatio);
                    }

                    Timer {
                        id: zombieTimer

                        property int zombineHandNumber: 1

                        interval: 60
                        repeat: true

                        onTriggered: if (zombineHandNumber < 8)
                            parent.source = '../../resources/images/zombieHand' + zombineHandNumber++ + '.png'
                    }
                }
                Image {
                    asynchronous: true
                    height: width * (sourceSize.height / sourceSize.width)
                    mipmap: true
                    source: quitMouseArea.containsMouse ? '../../resources/images/quitHovered.png' : '../../resources/images/quit.png'
                    width: parent.width * 0.045
                    x: parent.width * 0.91
                    y: parent.height * 0.85

                    onStatusChanged: if (status === Image.Ready) {
                        const aspectRatio = sourceSize.width / sourceSize.height;
                        sourceSize = Qt.size(width, width / aspectRatio);
                    }

                    MouseArea {
                        id: quitMouseArea

                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onClicked: quitDialogLoader.active = true
                        onEntered: bleepSound.play()
                    }
                }
                Loader {
                    id: quitDialogLoader

                    active: false
                    anchors.centerIn: parent
                    asynchronous: true
                    height: active && status === Loader.Ready ? width / item.aspectRatio : 0
                    width: parent.width * 0.3

                    sourceComponent: QuitDialog {
                        id: quitDialog

                        onCanceled: quitDialogLoader.active = false
                        onQuitted: root.quitted()
                    }
                }
                Image {
                    asynchronous: true
                    height: width * (sourceSize.height / sourceSize.width)
                    mipmap: true
                    source: helpMouseArea.containsMouse ? '../../resources/images/helpHovered.png' : '../../resources/images/help.png'
                    width: parent.width * 0.05
                    x: parent.width * 0.815
                    y: parent.height * 0.86

                    onStatusChanged: if (status === Image.Ready) {
                        const aspectRatio = sourceSize.width / sourceSize.height;
                        sourceSize = Qt.size(width, width / aspectRatio);
                    }

                    MouseArea {
                        id: helpMouseArea

                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onClicked: loader.sourceComponent = helpPaperComponent
                        onEntered: bleepSound.play()
                    }
                }
                MediaPlayer {
                    id: bleepSound

                    source: '../../resources/sound/bleep.wav'

                    audioOutput: AudioOutput {
                    }
                }
            }
        }
        Component {
            id: helpPaperComponent

            HelpPaper {
                onMainMenuButtonClicked: loader.sourceComponent = mainMenuComponent
            }
        }
    }
}
