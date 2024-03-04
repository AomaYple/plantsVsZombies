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
            width: parent.width * 0.4
            x: parent.width * 0.52
            y: parent.height * 0.1

            onClicked: {
                enabled = quitButton.enabled = false;
                zombieHandRise.rise();
            }
            onEntered: bleepSound.play()
        }
        ZombieHandRise {
            id: zombieHandRise

            width: parent.width * 0.27
            x: parent.width * 0.25
            y: parent.height * 0.47

            onRose: root.adventured()
        }
        QuitButton {
            id: quitButton

            width: parent.width * 0.06
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
