import QtQuick

Item {
    height: width / 73 * 49

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: '../../resources/scenes/shadow.png'
        sourceSize: Qt.size(width, height)
    }
}
