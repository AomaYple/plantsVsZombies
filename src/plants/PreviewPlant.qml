import QtQuick

Image {
    asynchronous: true
    height: parent.height * 0.15
    mipmap: true
    sourceSize: Qt.size(width, height)
    width: height
}
