import QtQuick
import QtMultimedia

Window {
    color: '#000000'
    title: '植物大战僵尸'
    visibility: Window.FullScreen

    Component.onCompleted: backgroundMusic.play()

    Loader {
        id: backgroundLoader

        anchors.fill: parent
        asynchronous: true

        sourceComponent: PopCapLogo {
            fadeTime: 2000

            onStopped: backgroundLoader.sourceComponent = titleScreenComponent
        }

        Component {
            id: titleScreenComponent

            TitleScreen {
                loadTime: 9000

                onClicked: backgroundLoader.sourceComponent = mainMenuComponent
            }
        }
        Component {
            id: mainMenuComponent

            MainMenu {
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
