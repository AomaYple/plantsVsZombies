import QtQuick

Item {
    width: height / 63 * 59

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: rootPath + '/resources/scenes/shovel.png'
        sourceSize: Qt.size(width, height)
    }
}
