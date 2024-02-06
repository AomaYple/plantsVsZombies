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
                anchors.fill: parent
                asynchronous: true
                mipmap: true
                source: '../../resources/images/mainMenu.png'

                Image {
                    asynchronous: true
                    height: width * (sourceSize.height / sourceSize.width)
                    mipmap: true
                    source: startAdventureMouseArea.containsMouse ? '../../resources/images/startAdventureHovered.png' : '../../resources/images/startAdventure.png'
                    width: parent.width * 0.3
                    x: parent.width * 0.56
                    y: parent.height * 0.09

                    MouseArea {
                        id: startAdventureMouseArea

                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true

                        onEntered: bleepSound.play()
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
