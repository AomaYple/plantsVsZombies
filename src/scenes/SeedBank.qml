import QtQuick
import QtMultimedia
import "../plants" as Plants

Image {
    id: root

    property bool planting: false
    readonly property int sunlightSum: parseInt(text.text)

    signal plantCanceled
    signal plantStarted(url previewPlantSource)
    signal planted

    function decreaseSunlight(count) {
        text.text = (parseInt(text.text) - count).toString();
    }
    function emerge() {
        yAnimator.start();
    }
    function increaseSunlight() {
        text.text = (parseInt(text.text) + 25).toString();
    }

    asynchronous: true
    enabled: parent.enabled
    height: parent.height * 0.145
    mipmap: true
    source: '../../resources/scenes/seedBank.png'
    sourceSize: Qt.size(width, height)
    width: height / 87 * 446
    x: parent.width * 0.01
    y: -height

    onPlanted: {
        planting = false;
        sunflowerSeed.planted();
    }

    Text {
        id: text

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
    Plants.Seed {
        id: sunflowerSeed

        source: '../../resources/plants/sunflowerSeed.png'
        sunlightConsumption: 50
        x: parent.width * 0.17

        onBuzzered: soundEffect.play()
        onPlantCanceled: {
            parent.planting = false;
            parent.plantCanceled();
        }
        onPlantStarted: previewPlantSource => {
            parent.planting = true;
            parent.plantStarted(previewPlantSource);
        }
        onSunlightDecreased: count => parent.decreaseSunlight(count)
    }
}
