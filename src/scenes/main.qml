import QtQuick
import QtMultimedia

Window {
    id: window

    color: '#000000'
    flags: Qt.Window | Qt.CustomizeWindowHint | Qt.WindowTitleHint | Qt.WindowCloseButtonHint | Qt.WindowMinimizeButtonHint
    height: 600
    maximumHeight: height
    maximumWidth: width
    minimumHeight: height
    minimumWidth: width
    title: '植物大战僵尸'
    visible: true
    width: 800

    Loader {
        id: loader

        anchors.fill: parent

        sourceComponent: LoadScreen {
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
                    backgroundMusic.source = '../../resources/music/chooseYourSeeds.flac';
                    backgroundMusic.play();
                }
                onBackToMainMenu: {
                    loader.sourceComponent = mainMenuComponent;
                    backgroundMusic.source = '../../resources/music/crazyDave.flac';
                    backgroundMusic.play();
                }
                onChose: backgroundMusic.source = ''
                onStarted: {
                    backgroundMusic.source = '../../resources/music/grassWalk.flac';
                    backgroundMusic.play();
                }
            }
        }

        MediaPlayer {
            id: backgroundMusic

            loops: MediaPlayer.Infinite
            source: '../../resources/music/crazyDave.flac'

            audioOutput: AudioOutput {
            }

            Component.onCompleted: play()
        }
    }
}
