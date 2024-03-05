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
            onClicked: {
                enabled = quitButton.enabled = false;
                zombieHandRise.rise();
            }
            onEntered: bleepSound.play()
        }
        ZombieHandRise {
            id: zombieHandRise

            onRose: root.adventured()
        }
        QuitButton {
            id: quitButton

            onEntered: bleepSound.play()
            onQuit: root.quit()
        }
        SoundEffect {
            id: bleepSound

            source: '../../resources/sounds/bleep.wav'
        }
    }
}
