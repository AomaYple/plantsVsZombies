import QtQuick
import "../js/common.js" as Common

AnimatedImage {
    asynchronous: true
    mipmap: true
    source: '../../resources/zombies/diedZombie' + Common.getRandomInt(0, 2) + '.gif'
    sourceSize: Qt.size(width, height)
    width: height / 136 * 180
}
