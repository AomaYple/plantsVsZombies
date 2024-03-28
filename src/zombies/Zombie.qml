import QtQuick
import "../scenes" as Scenes

Item {
    id: item

    required property int attackValue
    property bool attacking: false
    required property int lifeValue
    property alias paused: animatedImage.paused
    property alias source: animatedImage.source
    property real speed: 0.01
    required property int type

    signal attacked
    signal died
    signal froze

    function decelerate() {
        if (frozenTimer.running)
            frozenTimer.restart();
        else {
            frozenTimer.start();
            speed /= 2;
            if (!moveAnimation.paused)
                moveAnimation.restart();
            attackTimer.interval *= 2;
            animatedImage.speed /= 2;
            froze();
        }
    }

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

    function twinkle() {
        twinkleAnimation.start();
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
        id: moveAnimation

        duration: target.x / target.speed
        paused: target.paused || target.attacking
        properties: 'x'
        running: true
        target: item
        to: 0

        onPausedChanged: if (!paused)
            restart()
    }

    Scenes.SuspendableTimer {
        id: attackTimer

        interval: 600
        paused: parent.paused
        repeat: true
        running: parent.attacking

        onTriggered: parent.attacked()
    }

    NumberAnimation {
        id: twinkleAnimation

        duration: 250
        paused: running && target.paused
        properties: 'opacity'
        target: item
        to: 0.5

        onFinished: if (to === 0.5) {
            to = 1;
            start();
        } else
            to = 0.5
    }

    Scenes.SuspendableTimer {
        id: frozenTimer

        interval: 10000
        paused: parent.paused

        onTriggered: {
            animatedImage.speed *= 2;
            attackTimer.interval /= 2;
            parent.speed *= 2;
            if (!moveAnimation.paused)
                moveAnimation.restart();
        }
    }
}
