import QtQuick
import "../scenes" as Scenes

Item {
    id: item

    property bool attack: true
    readonly property int attackValue: 1
    required property real endPositionX
    property alias paused: numberAnimation.paused
    property url source: '../../res/plants/pea.png'
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

        duration: (target.endPositionX - target.x) / 0.3
        paused: target.paused
        properties: 'x'
        running: true
        target: item
        to: target.endPositionX

        onFinished: target.destroy()
    }
}
