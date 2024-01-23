import QtQuick
import QtMultimedia

Window {
    color: '#000000'
    height: 1080
    title: '植物大战僵尸'
    visible: true
    width: 1920

    Component.onCompleted: backgroundMusic.play()

    Image {
        id: background

        property real fadeTime: 2000

        anchors.fill: parent
        asynchronous: true
        cache: false
        mipmap: true
        opacity: 0
        source: '../../resources/images/popCapLogo.png'

        OpacityAnimator {
            duration: background.fadeTime
            running: true
            target: background
            to: 1

            onStopped: popCapLogoFadeOut.start()
        }
        OpacityAnimator {
            id: popCapLogoFadeOut

            duration: background.fadeTime
            target: background
            to: 0

            onStopped: {
                background.opacity = 1;
                background.source = '../../resources/images/titleScreen.png';
                loadBarLoader.active = true;
            }
        }
        Loader {
            id: loadBarLoader

            active: false
            height: parent.height * 0.15
            width: parent.width * 0.4

            sourceComponent: LoadBar {
                loadTime: 12000
            }

            anchors {
                bottom: parent.bottom
                bottomMargin: parent.height * 0.1
                horizontalCenter: parent.horizontalCenter
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
