import QtQuick
import QtMultimedia

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
                    height: parent.height * 0.15
                    loadTime: 12000
                    width: parent.width * 0.4

                    anchors {
                        bottom: parent.bottom
                        bottomMargin: parent.height * 0.1
                        horizontalCenter: parent.horizontalCenter
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
