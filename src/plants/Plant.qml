import QtQuick

Item {
    required property int lifeValue
    property alias paused: animatedImage.paused
    required property bool shoveling
    property alias source: animatedImage.source
    required property int type

    signal currentFrameChanged(int currentFrame)

    width: height

    AnimatedImage {
        id: animatedImage

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        opacity: parent.shoveling ? 0.8 : 1
        sourceSize: Qt.size(width, height)
        z: 1

        onCurrentFrameChanged: parent.currentFrameChanged(currentFrame)
    }
}
