import QtQuick
import QtMultimedia
import "../scenes" as Scenes
import "../js/common.js" as Common

Item {
    id: root

    required property int damageValue
    required property real endPositionX
    required property int lifeValue
    property alias paused: animatedImage.paused
    property alias source: animatedImage.source
    property real speed: 0.011
    required property int type

    signal died

    function die() {
        lifeValue = 0;
    }

    onLifeValueChanged: if (lifeValue <= 0) {
        destroy();
        died();
    }

    Scenes.Shadow {
        height: parent.height * 0.3
        x: parent.width * 0.3
        y: parent.height * 0.75
    }
    AnimatedImage {
        id: animatedImage

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        sourceSize: Qt.size(width, height)
    }
    NumberAnimation {
        duration: Math.abs(root.x - root.endPositionX) / root.speed
        paused: root.paused
        properties: 'x'
        running: true
        target: root
        to: root.endPositionX - root.width

        onFinished: root.die()
    }
    SoundEffect {
        source: rootPath + '/resources/sounds/groan' + Common.getRandomInt(0, 5) + '.wav'

        Component.onCompleted: play()
    }
}
