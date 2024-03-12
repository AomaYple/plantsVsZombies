import QtQuick
import "../scenes" as Scenes

Item {
    width: height / 3

    Scenes.Shadow {
        height: parent.height * 0.2

        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
    }
    Image {
        anchors.top: parent.top
        asynchronous: true
        height: parent.height * 0.3
        mipmap: true
        sourceSize: Qt.size(width, height)
        width: parent.width
    }
}