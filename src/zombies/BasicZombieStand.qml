import QtQuick
import "../scenes" as Zombies

Item {
    height: width / 84 * 126

    AnimatedImage {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: '../../resources/zombies/basicZombieStand' + Math.round(Math.random()) + '.gif'
        sourceSize: Qt.size(width, height)

        Zombies.Shadow {
            width: parent.width * 0.6
            x: parent.width * 0.36
            y: parent.height * 0.78
        }
    }
}
