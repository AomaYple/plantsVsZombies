import QtQuick
import QtMultimedia
import "../plants" as Plants

Image {
    id: root

    property bool paused: parent.paused
    property int sunlightSum: parseInt(sunlightSum.text)

    function addSunlight() {
        sunlightSum.text = (parseInt(sunlightSum.text) + 25).toString();
    }
    function emerge() {
        yAnimator.start();
    }

    asynchronous: true
    height: parent.height * 0.145
    mipmap: true
    source: '../../resources/scenes/seedBank.png'
    sourceSize: Qt.size(width, height)
    width: height / 87 * 446
    x: parent.width * 0.01
    y: -height

    Text {
        id: sunlightSum

        function decreaseSunlight(count) {
            text = (parseInt(sunlightSum.text) - count).toString();
        }

        color: '#000000'
        text: '50'
        x: parent.width * 0.085 - width / 2
        y: parent.height * 0.82 - height / 2

        font {
            bold: true
            pointSize: Math.max(parent.height * 0.1, 1)
        }
    }
    YAnimator {
        id: yAnimator

        duration: 500
        target: root
        to: 0
    }
    SoundEffect {
        id: soundEffect

        source: '../../resources/sounds/buzzer.wav'
    }
    Plants.SunflowerSeed {
        onBuzzered: soundEffect.play()
        onSunlightConsumed: count => sunlightSum.decreaseSunlight(count)
    }
}
