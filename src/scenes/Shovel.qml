import QtQuick

Image {
    asynchronous: true
    mipmap: true
    source: rootPath + '/resources/scenes/shovel.png'
    sourceSize: Qt.size(width, height)
    width: height / 63 * 59
    z: 3
}
