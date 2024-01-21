import QtQuick
import QtMultimedia

Window {
    color: '#000000'
    height: 540
    title: '植物大战僵尸'
    visible: true
    width: 960

    Component.onCompleted: backgroundMusic.play()

    Image {
        id: popCapLogo

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        opacity: 0
        source: '../../resources/images/popCapLogo.png'

        SequentialAnimation {
            running: true

            onStopped: titleScreen.source = '../../resources/images/titleScreen.png'

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
    Image {
        id: titleScreen

        anchors.fill: parent
        asynchronous: true
        mipmap: true
    }
    MediaPlayer {
        id: backgroundMusic

        loops: MediaPlayer.Infinite
        source: '../../resources/music/crazyDave.flac'

        audioOutput: AudioOutput {
        }
    }
}
