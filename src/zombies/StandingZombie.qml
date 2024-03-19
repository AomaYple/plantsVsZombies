import QtQuick
import "../scenes" as Scenes

Item {
    property alias source: animatedImage.source

    Scenes.Shadow {
        height: parent.height * 0.3
        x: parent.width * 0.33
        y: parent.height * 0.76
    }

    AnimatedImage {
        id: animatedImage

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        sourceSize: Qt.size(width, height)
    }
}
