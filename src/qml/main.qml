import QtQuick
import QtMultimedia

Window {
    id: root

    color: '#000000'
    title: '植物大战僵尸'
    visibility: Window.FullScreen

    Component.onCompleted: backgroundMusic.play()

    Loader {
        id: backgroundLoader

        anchors.horizontalCenter: parent.horizontalCenter
        asynchronous: true
        height: parent.height
        width: height / 3 * 4

        sourceComponent: PopCapLogo {
            onFinished: backgroundLoader.sourceComponent = titleScreen
        }

        Component {
            id: titleScreen

            TitleScreen {
                onStarted: backgroundLoader.sourceComponent = mainMenu
            }
        }
        Component {
            id: mainMenu

            MainMenu {
                onAdventured: backgroundLoader.sourceComponent = daytimeGrass
                onQuit: root.close()
            }
        }
        Component {
            id: daytimeGrass

            DaytimeGrass {
                onChoose: {
                    backgroundMusic.source = '../../resources/music/ChooseYourSeeds.flac';
                    backgroundMusic.play();
                }
                onChose: {
                    backgroundMusic.source = '../../resources/sounds/readySetPlant.flac';
                    backgroundMusic.play();
                }
                onStarted: {
                    backgroundMusic.source = '../../resources/music/GrassWalk.flac';
                    backgroundMusic.play();
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
}
