import QtQuick
import QtMultimedia
import "../scenes" as Scenes
import "../js/common.js" as Common

Item {
    id: root

    readonly property int damageValue: 1
    required property real endPositionX
    property alias paused: numberAnimation.paused

    width: height / 2
    z: 2

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
        source: rootPath + '/resources/plants/pea.png'
        sourceSize: Qt.size(width, height)
        width: parent.width
    }
    NumberAnimation {
        id: numberAnimation

        duration: (root.endPositionX - root.x) / 0.3
        paused: root.paused
        properties: 'x'
        running: true
        target: root
        to: root.endPositionX

        onFinished: root.destroy()
    }
    SoundEffect {
        id: soundEffect

        source: rootPath + '/resources/sounds/splat' + Common.getRandomInt(0, 2) + '.wav'
    }
}