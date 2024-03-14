import QtQuick

Item {
    width: height / 49 * 73

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: rootPath + '/resources/scenes/shadow.png'
        sourceSize: Qt.size(width, height)
    }
}
