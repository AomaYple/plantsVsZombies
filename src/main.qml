import QtQuick
import QtMultimedia
import "scenes" as Scenes

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

        sourceComponent: Scenes.LoadScreen {
            onLoaded: loader.sourceComponent = mainMenu
        }

        Component {
            id: mainMenu

            Scenes.MainMenu {
                onAdventured: loader.sourceComponent = daytimeGrass
                onQuit: root.close()
            }
        }
    }
    MediaPlayer {
        id: mediaPlayer

        loops: MediaPlayer.Infinite
        source: rootPath + '/resources/music/crazyDave.flac'

        audioOutput: AudioOutput {
        }

        Component.onCompleted: play()
    }
}
