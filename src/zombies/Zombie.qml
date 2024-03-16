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
    readonly property real speed: 0.01
    required property int type

    signal died

    function die() {
        destroy();
        died();
    }

    function playSplat() {
        splat.play();
    }

    function startAttack(attackTargetObject) {
        attackTarget = attackTargetObject;
        chomp.play();
        attackTarget.died.connect(function () {
            stopAttack();
            gulp.play();
        });
        attackTarget.shovelled.connect(function () {
            stopAttack();
        });
    }

    function stopAttack() {
        attackTarget = null;
        chomp.stop();
    }

    function twinkle() {
        numberAnimation.running = true;
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
        paused: running && parent.paused
        repeat: true
        running: parent.attackTarget

        onTriggered: {
            parent.attackTarget.lifeValue -= parent.attackValue;
            parent.attackTarget.twinkle();
        }
    }

    SoundEffect {
        id: chomp

        loops: SoundEffect.Infinite
        source: '../../resources/sounds/chomp' + Common.getRandomInt(0, 2) + '.wav'
    }

    SoundEffect {
        id: gulp

        source: '../../resources/sounds/gulp.wav'
    }

    NumberAnimation {
        id: numberAnimation

        duration: 250
        paused: running && item.paused
        properties: 'opacity'
        target: animatedImage
        to: 0.5

        onFinished: if (to === 0.5) {
            to = 1;
            running = true;
        } else
            to = 0.5
    }

    SoundEffect {
        id: splat

        source: '../../resources/sounds/splat' + Common.getRandomInt(0, 2) + '.wav'
    }
}
