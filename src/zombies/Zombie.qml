import QtQuick
import QtMultimedia
import "../scenes" as Scenes
import "../js/common.js" as Common

Item {
    id: item

    property var attackTarget: null
    required property int attackValue
    required property real endPositionX
    required property int lifeValue
    property alias paused: animatedImage.paused
    property alias source: animatedImage.source
    readonly property real speed: 0.011
    required property int type

    signal died

    function die() {
        destroy();
        died();
    }

    function startAttack(attackTargetObject) {
        attackTarget = attackTargetObject;
        attackTargetObject.onDied = function () {
            attackTarget = null;
        };
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

    SoundEffect {
        source: '../../resources/sounds/groan' + Common.getRandomInt(0, 5) + '.wav'

        Component.onCompleted: play()
    }

    NumberAnimation {
        duration: Math.abs(item.x - item.endPositionX) / item.speed
        paused: item.paused || item.attackTarget
        properties: 'x'
        running: true
        target: item
        to: item.endPositionX - item.width

        onFinished: item.die()
    }

    Scenes.SuspendableTimer {
        interval: 500
        repeat: true
        running: !parent.paused && parent.attackTarget

        onTriggered: parent.attackTarget.lifeValue -= parent.attackValue
    }
}
