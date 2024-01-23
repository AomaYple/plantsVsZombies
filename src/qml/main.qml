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

            property real fadeTime: 1

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
                    height: parent.height * 0.15
                    loadTime: 1
                    width: parent.width * 0.4

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

                Button {
                    x: parent.width * 0.73
                    y: parent.height * 0.8

                    background: Rectangle {
                        color: 'transparent'
                    }
                    contentItem: Text {
                        color: parent.hovered ? '#ffffff' : '#000000'
                        font.pointSize: mainMenu.height * 0.03
                        text: '选项'
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                    }
                }
                Button {
                    x: parent.width * 0.82
                    y: parent.height * 0.85

                    background: Rectangle {
                        color: 'transparent'
                    }
                    contentItem: Text {
                        color: parent.hovered ? '#ffffff' : '#000000'
                        font.pointSize: mainMenu.height * 0.03
                        text: '帮助'
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                    }
                }
                Button {
                    x: parent.width * 0.9
                    y: parent.height * 0.83

                    background: Rectangle {
                        color: 'transparent'
                    }
                    contentItem: Text {
                        color: parent.hovered ? '#ffffff' : '#000000'
                        font.pointSize: mainMenu.height * 0.03
                        text: '退出'
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
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
