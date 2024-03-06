import QtQuick
import "../scenes" as Scenes

AnimatedImage {
    asynchronous: true
    mipmap: true
    source: '../../resources/zombies/basicZombieStand' + Math.round(Math.random()) + '.gif'
    width: height / 126 * 84

    Scenes.Shadow {
        height: parent.height * 0.3
        x: parent.width * 0.33
        y: parent.height * 0.76
    }
}
