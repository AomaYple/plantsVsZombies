import QtQuick

Item {
    width: height

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        sourceSize: Qt.size(width, height)
    }
}
