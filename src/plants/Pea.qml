import QtQuick
import QtMultimedia
import "../scenes" as Scenes
import "../js/common.js" as Common

Item {
    id: item

    readonly property int damageValue: 1
    required property real endPositionX
    property alias paused: numberAnimation.paused
    readonly property real speed: 0.3

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
        source: '../../resources/plants/pea.png'
        sourceSize: Qt.size(width, height)
        width: parent.width
    }

    NumberAnimation {
        id: numberAnimation

        duration: (item.endPositionX - item.x) / item.speed
        paused: item.paused
        properties: 'x'
        running: true
        target: item
        to: item.endPositionX

        onFinished: item.destroy()
    }

    SoundEffect {
        id: soundEffect

        source: '../../resources/sounds/splat' + Common.getRandomInt(0, 2) + '.wav'
    }
}
