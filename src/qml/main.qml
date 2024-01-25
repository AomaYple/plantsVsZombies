import QtQuick
import QtMultimedia
import QtQuick.Controls

Window {
    color: '#000000'
    height: 1080
    title: '植物大战僵尸'
    visible: true
    width: 1920

    Component.onCompleted: backgroundMusic.play()

    Loader {
        id: backgroundLoader

        anchors.fill: parent

        sourceComponent: Image {
            id: popCapLogo

            property real fadeTime: 2000

            asynchronous: true
            mipmap: true
            opacity: 0
            source: '../../resources/images/popCapLogo.png'

            OpacityAnimator {
                duration: popCapLogo.fadeTime
                running: true
                target: popCapLogo
                to: 1

                onStopped: popCapLogoFadeOut.start()
            }
            OpacityAnimator {
                id: popCapLogoFadeOut

                duration: popCapLogo.fadeTime
                target: popCapLogo
                to: 0

                onStopped: backgroundLoader.sourceComponent = titleScreenComponent
            }
        }

        Component {
            id: titleScreenComponent

            Image {
                asynchronous: true
                mipmap: true
                source: '../../resources/images/titleScreen.png'

                LoadBar {
                    height: parent.height * 0.14
                    loadTime: 1000
                    width: parent.width * 0.3

                    onClicked: backgroundLoader.sourceComponent = mainMenuComponent

                    anchors {
                        bottom: parent.bottom
                        bottomMargin: parent.height * 0.1
                        horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }
        Component {
            id: mainMenuComponent

            Image {
                id: mainMenu

                asynchronous: true
                mipmap: true
                source: '../../resources/images/mainMenu.png'

                Image {
                    asynchronous: true
                    height: parent.height * 0.05
                    mipmap: true
                    source: quitButton.hovered ? '../../resources/images/quitHovered.png' : '../../resources/images/quit.png'
                    width: parent.width * 0.04

                    anchors {
                        bottom: parent.bottom
                        bottomMargin: parent.height * 0.1
                        right: parent.right
                        rightMargin: parent.width * 0.05
                    }
                    Button {
                        anchors.fill: parent

                        background: Rectangle {
                            color: 'transparent'
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                        }
                    }
                }
                Image {
                    asynchronous: true
                    height: parent.height * 0.04
                    mipmap: true
                    source: startButton.hovered ? '../../resources/images/helpHovered.png' : '../../resources/images/help.png'
                    width: parent.width * 0.04

                    anchors {
                        bottom: parent.bottom
                        bottomMargin: parent.height * 0.09
                        right: parent.right
                        rightMargin: parent.width * 0.14
                    }
                    Button {
                        anchors.fill: parent

                        background: Rectangle {
                            color: 'transparent'
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                        }
                    }
                }
                Image {
                    asynchronous: true
                    height: parent.height * 0.05
                    mipmap: true
                    source: helpButton.hovered ? '../../resources/images/optionsHovered.png' : '../../resources/images/options.png'
                    width: parent.width * 0.06

                    anchors {
                        bottom: parent.bottom
                        bottomMargin: parent.height * 0.13
                        right: parent.right
                        rightMargin: parent.width * 0.215
                    }
                    Button {
                        anchors.fill: parent

                        background: Rectangle {
                            color: 'transparent'
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                        }
                    }
                }
            }
        }
    }
    MediaPlayer {
        id: backgroundMusic

        loops: MediaPlayer.Infinite
        source: '../../resources/music/CrazyDave.flac'

        audioOutput: AudioOutput {
        }
    }
}
