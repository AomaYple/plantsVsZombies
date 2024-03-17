import QtQuick
import "../scenes" as Scenes

Item {
    id: item

    readonly property int attackValue: 1
    required property real endPositionX
    property alias paused: numberAnimation.paused
    property url source: '../../resources/plants/pea.png'
    property int type: PeaType.Type.Pea

    width: height / 2

    Scenes.Shadow {
        height: parent.width * 0.5

        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
    }

    Image {
        anchors.top: parent.top
        asynchronous: true
        height: width
        mipmap: true
        source: parent.source
        sourceSize: Qt.size(width, height)
        width: parent.width
    }

    NumberAnimation {
        id: numberAnimation

        duration: (item.endPositionX - item.x) / 0.3
        paused: item.paused
        properties: 'x'
        running: true
        target: item
        to: item.endPositionX

        onFinished: item.destroy()
    }
}
