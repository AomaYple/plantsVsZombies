import QtQuick
import "../scenes" as Scenes

Item {
    width: height / 126 * 84

    Scenes.Shadow {
        height: parent.height * 0.3
        x: parent.width * 0.33
        y: parent.height * 0.76
    }
    AnimatedImage {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: rootPath + '/resources/zombies/basicZombieStand' + Math.round(Math.random()) + '.gif'
    }
}
