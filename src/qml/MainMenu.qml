import QtQuick
import QtMultimedia

Item {
    id: root

    signal adventured
    signal quit

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: '../../resources/scenes/mainMenu.png'
        sourceSize: Qt.size(width, height)

        StartAdventure {
            height: parent.height * 0.23
            width: height / 142 * 331
            x: parent.width * 0.52
            y: parent.height * 0.1

            onClicked: {
                enabled = quitButton.enabled = false;
                zombieHand.rise();
            }
            onEntered: bleepSound.play()
        }

        ZombieHand {
            id: zombieHand

            height: parent.height * 0.5
            width: height
            x: parent.width * 0.28
            y: parent.height * 0.48

            onRose: root.adventured()
        }

        QuitButton {
            id: quitButton

            height: parent.height * 0.04
            width: height / 23 * 43
            x: parent.width * 0.903
            y: parent.height * 0.86

            onEntered: bleepSound.play()
            onQuit: root.quit()
        }

        SoundEffect {
            id: bleepSound

            source: '../../resources/sounds/bleep.wav'
        }
    }
}
