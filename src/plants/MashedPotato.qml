import QtQuick
import "../scenes" as Scenes

Image {
    required property bool paused

    asynchronous: true
    mipmap: true
    source: '../../resources/plants/mashedPotato.png'
    sourceSize: Qt.size(width, height)

    Scenes.SuspendableTimer {
        interval: 1000
        paused: parent.paused
        running: true

        onTriggered: parent.destroy()
    }
}
