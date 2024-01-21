import QtQuick
import QtMultimedia

Window {
    color: '#000000'
    height: 540
    title: '植物大战僵尸'
    visible: true
    width: 960

    Component.onCompleted: backgroundMusic.play()

    Loader {
        id: background

        anchors.fill: parent
        asynchronous: true
        sourceComponent: popCapLogoComponent
    }
    Component {
        id: popCapLogoComponent

        Image {
            id: popCapLogo

            anchors.centerIn: parent
            asynchronous: true
            mipmap: true
            opacity: 0
            source: '../../resources/images/popCapLogo.png'

            SequentialAnimation {
                running: true

                onStopped: background.sourceComponent = titleScreenComponent

                NumberAnimation {
                    duration: 2000
                    properties: 'opacity'
                    target: popCapLogo
                    to: 1
                }
                NumberAnimation {
                    duration: 2000
                    properties: 'opacity'
                    target: popCapLogo
                    to: 0
                }
            }
        }
    }
    Component {
        id: titleScreenComponent

        Image {
            anchors.fill: parent
            asynchronous: true
            mipmap: true
            source: '../../resources/images/titleScreen.png'
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
