import QtQuick
import QtMultimedia

Window {
    id: window

    color: '#000000'
    title: '植物大战僵尸'
    visibility: Window.FullScreen

    Loader {
        id: loader

        anchors.horizontalCenter: parent.horizontalCenter
        asynchronous: true
        height: parent.height
        width: height / 3 * 4

        sourceComponent: LoadingScreen {
            onLoaded: loader.sourceComponent = mainMenuComponent
        }

        Component {
            id: mainMenuComponent

            MainMenu {
                onAdventured: loader.sourceComponent = daytimeGrassComponent
                onQuit: window.close()
            }
        }
        Component {
            id: daytimeGrassComponent

            DaytimeGrass {
                Component.onCompleted: {
                    backgroundMusic.source = '../../resources/music/ChooseYourSeeds.flac';
                    backgroundMusic.play();
                }
                onBackToMainMenu: {
                    loader.sourceComponent = mainMenuComponent;
                    backgroundMusic.source = '../../resources/music/CrazyDave.flac';
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

            Component.onCompleted: play()
        }
    }
}
