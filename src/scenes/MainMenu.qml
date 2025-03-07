import QtQuick
import QtMultimedia

Image {
    signal adventured
    signal quit

    asynchronous: true
    mipmap: true
    source: '../res/scenes/mainMenu.png'
    sourceSize: Qt.size(width, height)

    StartAdventure {
        enabled: parent.enabled
        height: parent.height * 0.23
        x: parent.width * 0.52
        y: parent.height * 0.1

        onClicked: {
            parent.enabled = false;
            zombieHand.rise();
        }
        onEntered: soundEffect.play()
    }

    ZombieHand {
        id: zombieHand

        height: parent.height * 0.5
        x: parent.width * 0.25
        y: parent.height * 0.47

        onRose: parent.adventured()
    }

    QuitButton {
        enabled: parent.enabled
        height: parent.height * 0.04
        x: parent.width * 0.903
        y: parent.height * 0.86

        onEntered: soundEffect.play()
        onQuit: parent.quit()
    }

    SoundEffect {
        id: soundEffect

        source: '../../res/sounds/bleep.wav'
    }
}
