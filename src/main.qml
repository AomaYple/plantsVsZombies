import QtQuick
import QtMultimedia
import "scenes" as Scenes

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

        sourceComponent: Scenes.LoadScreen {
            onLoaded: loader.sourceComponent = mainMenu
        }

        Component {
            id: mainMenu

            Scenes.MainMenu {
                onAdventured: loader.sourceComponent = gameScene
                onQuit: window.close()
            }
        }

        Component {
            id: gameScene

            Scenes.GameScene {
                Component.onCompleted: {
                    mediaPlayer.source = '../res/music/chooseYourSeeds.flac';
                    mediaPlayer.play();
                }
                onBackToMainMenu: {
                    loader.sourceComponent = mainMenu;
                    mediaPlayer.source = '../res/music/crazyDave.flac';
                    mediaPlayer.play();
                }
                onChose: mediaPlayer.stop()
                onStarted: {
                    mediaPlayer.source = '../res/music/grassWalk.flac';
                    mediaPlayer.play();
                }
            }
        }
    }

    MediaPlayer {
        id: mediaPlayer

        loops: MediaPlayer.Infinite
        source: '../res/music/crazyDave.flac'

        audioOutput: AudioOutput {
            volume: 0.8
        }

        Component.onCompleted: play()
    }
}
