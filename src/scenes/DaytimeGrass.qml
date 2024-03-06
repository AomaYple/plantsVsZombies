import QtQuick
import "../zombies" as Zombies

Item {
    id: root

    signal finished

    anchors.fill: parent

    Image {
        id: image

        asynchronous: true
        height: parent.height
        mipmap: true
        source: '../../resources/scenes/daytimeGrass.png'
        sourceSize: Qt.size(width, height)
        width: height / 600 * 1400

        onStatusChanged: if (status === Image.Ready)
            timer.start()

        Timer {
            id: timer

            interval: 1500

            onTriggered: xAnimator.start()
        }
        XAnimator {
            id: xAnimator

            duration: 2000
            target: image
            to: root.width - image.width

            onFinished: {
                if (to === root.width - image.width) {
                    to = -image.width * 0.157;
                    timer.start();
                } else {
                    basicZombieStand0.source = basicZombieStand1.source = basicZombieStand2.source = basicZombieStand3.source = '';
                    root.finished();
                }
            }
        }
        Zombies.BasicZombieStand {
            id: basicZombieStand0

            height: parent.height * 0.23
            x: parent.width * 0.82
            y: parent.height * 0.2
        }
        Zombies.BasicZombieStand {
            id: basicZombieStand1

            height: parent.height * 0.23
            x: parent.width * 0.86
            y: parent.height * 0.4
        }
        Zombies.BasicZombieStand {
            id: basicZombieStand2

            height: parent.height * 0.23
            x: parent.width * 0.9
            y: parent.height * 0.6
        }
        Zombies.BasicZombieStand {
            id: basicZombieStand3

            height: parent.height * 0.23
            x: parent.width * 0.85
            y: parent.height * 0.7
        }
    }
}
