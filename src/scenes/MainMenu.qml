import QtQuick
import QtMultimedia

Image {
    signal adventured
    signal quit

    asynchronous: true
    mipmap: true
    source: '../../resources/scenes/mainMenu.png'
    sourceSize: Qt.size(width, height)

    StartAdventure {
        onClicked: {
            parent.enabled = false;
            zombieHandRise.rise();
        }
        onEntered: soundEffect.play()
    }
    ZombieHandRise {
        id: zombieHandRise

        onRose: parent.adventured()
    }
    QuitButton {
        id: quitButton

        onEntered: soundEffect.play()
        onQuit: parent.quit()
    }
    SoundEffect {
        id: soundEffect

        source: '../../resources/sounds/bleep.wav'
    }
}
