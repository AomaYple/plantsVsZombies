import QtQuick
import QtMultimedia

Window {
    id: root

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
            onLoaded: loader.sourceComponent = mainMenu
        }

        Component {
            id: mainMenu

            MainMenu {
                onAdventured: loader.sourceComponent = gameScene
                onQuit: root.close()
            }
        }
        Component {
            id: gameScene

            GameScene {
                Component.onCompleted: {
                    mediaPlayer.source = '../../resources/music/chooseYourSeeds.flac';
                    mediaPlayer.play();
                }
                onBackToMainMenu: {
                    loader.sourceComponent = mainMenu;
                    mediaPlayer.source = '../../resources/music/crazyDave.flac';
                    mediaPlayer.play();
                }
                onChose: mediaPlayer.stop()
                onStarted: {
                    mediaPlayer.source = '../../resources/music/grassWalk.flac';
                    mediaPlayer.play();
                }
            }
        }
        MediaPlayer {
            id: mediaPlayer

            loops: MediaPlayer.Infinite
            source: '../../resources/music/crazyDave.flac'

            audioOutput: AudioOutput {
            }

            Component.onCompleted: play()
        }
    }
}
