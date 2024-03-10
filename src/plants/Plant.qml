import QtQuick
import "../scenes" as Scenes

Item {
    property alias paused: animatedImage.paused
    required property bool shoveling
    property alias source: animatedImage.source
    required property int type

    width: height

    Scenes.Shadow {
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height * 0.5
        y: parent.height * 0.6
    }
    AnimatedImage {
        id: animatedImage

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        opacity: parent.shoveling ? 0.8 : 1
        sourceSize: Qt.size(width, height)
    }
}
