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
        source: '../../resources/images/mainMenu.png'
        sourceSize: Qt.size(width, height)

        StartAdventure {
            height: parent.height * 0.25
            width: height / 584 * 1324
            x: parent.width * 0.5
            y: parent.height * 0.1

            onAdventured: root.adventured()
            onClicked: {
                enabled = quitButton.enabled = false;
                zombieHand.rise();
            }
            onEntered: bleep.play()
        }
        ZombieHand {
            id: zombieHand

            height: parent.height * 0.5
            width: height / 1254 * 820
            x: parent.width * 0.28
            y: parent.height * 0.48
        }
        QuitButton {
            id: quitButton

            height: parent.height * 0.04
            width: height / 92 * 176
            x: parent.width * 0.903
            y: parent.height * 0.86

            onEntered: bleep.play()
            onQuit: root.quit()
        }
        MediaPlayer {
            id: bleep

            source: '../../resources/sounds/bleep.wav'

            audioOutput: AudioOutput {
            }
        }
    }
}