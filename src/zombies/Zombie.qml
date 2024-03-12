import QtQuick
import "../scenes" as Scenes

Item {
    required property int damageValue
    required property int lifeValue
    property alias paused: animatedImage.paused
    property alias source: animatedImage.source
    required property int type

    Scenes.Shadow {
        height: parent.height * 0.3

        anchors {
            bottom: parent.bottom
            right: parent.right
        }
    }
    AnimatedImage {
        id: animatedImage

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        sourceSize: Qt.size(width, height)
    }
}
