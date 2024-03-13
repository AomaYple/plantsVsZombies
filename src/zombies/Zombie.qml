import QtQuick
import QtMultimedia
import "../scenes" as Scenes
import "../js/common.js" as Common

Item {
    id: root

    required property int attackValue
    property bool attacking: false
    required property real endPositionX
    required property int lifeValue
    property alias paused: animatedImage.paused
    property alias source: animatedImage.source
    property real speed: 0.011
    required property int type

    signal attacked
    signal died

    function die() {
        destroy();
        died();
    }
    function startAttack() {
        attacking = true;
    }
    function stopAttack() {
        attacking = false;
    }

    onLifeValueChanged: if (lifeValue <= 0)
        die()

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
        paused: root.paused || root.attacking
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
    Scenes.SuspendableTimer {
        interval: 500
        repeat: true
        running: !root.paused && root.attacking

        onTriggered: parent.attacked()
    }
}
