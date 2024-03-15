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
        splat.source = '../../resources/sounds/splat' + Common.getRandomInt(0, 2) + '.wav';
        splat.play();
    }

    function startAttack(attackTargetObject) {
        attackTarget = attackTargetObject;
        attackTargetObject.died.connect(function () {
            attackTarget = null;
            chomp.stop();
            gulp.play();
        });
        chomp.play();
    }

    function twinkle() {
        twinkle.start();
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
            parent.attackTarget.twinkle();
            parent.attackTarget.lifeValue -= parent.attackValue;
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

    SoundEffect {
        id: splat

    }

    NumberAnimation {
        id: twinkle

        duration: 250
        paused: running && item.paused
        properties: 'opacity'
        target: animatedImage
        to: 0.5

        onFinished: if (to === 0.5) {
            to = 1;
            start();
        } else
            to = 0.5
    }
}
