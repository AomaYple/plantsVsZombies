import QtQuick
import "../scenes" as Scenes

AnimatedImage {
    asynchronous: true
    mipmap: true
    source: rootPath + '/resources/plants/sunflower.gif'
    sourceSize: Qt.size(width, height)
    width: height

    Scenes.Shadow {
        height: parent.height * 0.3
        x: parent.width * 0.33
        y: parent.height * 0.76
    }
}
