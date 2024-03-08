import QtQuick
import QtMultimedia
import "../plants" as Plants

Image {
    id: root

    required property bool paused
    property bool planting: false
    property int sunlightConsumption: 0
    readonly property int sunlightSum: parseInt(sunlightSumText.text)

    signal plantCanceled
    signal plantStarted(url previewPlantSource, var plantComponent)

    function emerge() {
        yAnimator.start();
    }
    function increaseSunlight() {
        sunlightSumText.increase();
    }
    function plant() {
        planting = false;
        sunflowerSeed.plant();
        sunlightSumText.decrease(sunlightConsumption);
    }

    asynchronous: true
    enabled: false
    mipmap: true
    source: rootPath + '/resources/scenes/seedBank.png'
    sourceSize: Qt.size(width, height)
    width: height / 87 * 446
    y: -height

    Text {
        id: sunlightSumText

        function decrease(consumption) {
            text = (parseInt(text) - consumption).toString();
        }
        function increase() {
            text = (parseInt(text) + 25).toString();
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

        source: rootPath + '/resources/sounds/buzzer.wav'
    }
    Plants.Seed {
        id: sunflowerSeed

        enabled: parent.enabled && (!parent.planting || planting)
        height: parent.height * 0.84
        plantComponent: Qt.createComponent(rootPath + '/src/plants/Sunflower.qml', Component.Asynchronous)
        previewPlantSource: rootPath + '/resources/plants/sunflower.png'
        source: rootPath + '/resources/plants/sunflowerSeed.png'
        sunlightConsumption: 50
        x: parent.width * 0.17

        onBuzzered: soundEffect.play()
        onPlantCanceled: {
            parent.planting = false;
            parent.plantCanceled();
        }
        onPlantStarted: (previewPlantSource, plantComponent, sunlightConsumption) => {
            parent.planting = true;
            parent.sunlightConsumption = sunlightConsumption;
            parent.plantStarted(previewPlantSource, plantComponent);
        }
    }
}
