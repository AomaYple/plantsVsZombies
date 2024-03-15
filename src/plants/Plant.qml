import QtQuick
import QtMultimedia
import "../scenes" as Scenes

Item {
    id: item

    required property int lifeValue
    property alias paused: animatedImage.paused
    property alias shadowHeight: shadow.height
    required property point shadowPosition
    readonly property alias shadowWidth: shadow.width
    required property bool shoveling
    property alias source: animatedImage.source
    required property int type

    signal died

    function die() {
        destroy();
        soundEffect.play();
        died();
    }

    function shovel() {
        destroy();
        died();
    }

    function twinkle() {
        numberAnimation.start();
    }

    width: height

    onLifeValueChanged: if (lifeValue <= 0)
        die()

    Scenes.Shadow {
        id: shadow

        x: parent.shadowPosition.x
        y: parent.shadowPosition.y
    }

    AnimatedImage {
        id: animatedImage

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        opacity: parent.shoveling ? 0.8 : 1
        sourceSize: Qt.size(width, height)

        Binding {
            property: 'opacity'
            target: parent
            value: item.shoveling ? 0.8 : 1
            when: !numberAnimation.running
        }
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
            start();
        } else
            to = 0.5
    }

    SoundEffect {
        id: soundEffect

        source: '../../resources/sounds/gulp.wav'
    }
}