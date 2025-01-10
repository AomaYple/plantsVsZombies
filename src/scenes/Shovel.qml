import QtQuick

Image {
    asynchronous: true
    mipmap: true
    source: '../../res/scenes/shovel.png'
    sourceSize: Qt.size(width, height)
    width: height / 63 * 59
}
