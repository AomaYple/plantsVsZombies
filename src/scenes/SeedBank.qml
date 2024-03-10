import QtQuick
import QtMultimedia
import "../plants" as Plants

Image {
    id: root

    required property bool paused
    property bool planting: false

    signal plantCanceled
    signal plantStarted(url previewPlantSource, var plantComponent)

    function emerge() {
        yAnimator.start();
    }
    function increaseSunlight() {
        sunlightSum.increase();
    }
    function plant() {
        planting = false;
        sunflowerSeed.plant();
        sunlightSum.decrease();
    }

    asynchronous: true
    enabled: false
    mipmap: true
    source: rootPath + '/resources/scenes/seedBank.png'
    sourceSize: Qt.size(width, height)
    width: height / 87 * 446
    y: -height

    Text {
        id: sunlightSum

        property int sunlightConsumption

        function decrease() {
            text = (parseInt(text) - sunlightConsumption).toString();
        }
        function increase() {
            text = (parseInt(text) + 25).toString();
        }
        function sum() {
            return parseInt(text);
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

        anchors.verticalCenter: parent.verticalCenter
        cooldownTime: 7500
        enabled: parent.enabled && (!parent.planting || planting)
        height: parent.height * 0.84
        paused: parent.paused
        plantComponent: Qt.createComponent(rootPath + '/src/plants/Sunflower.qml', Component.Asynchronous)
        previewPlantSource: rootPath + '/resources/plants/sunflower.png'
        source: rootPath + '/resources/plants/sunflowerSeed.png'
        sunlightConsumption: 50
        sunlightSum: sunlightSum.sum()
        x: parent.width * 0.17

        onBuzzered: soundEffect.play()
        onPlantCanceled: {
            parent.planting = false;
            parent.plantCanceled();
        }
        onPlantStarted: {
            parent.planting = true;
            sunlightSum.sunlightConsumption = sunlightConsumption;
            parent.plantStarted(previewPlantSource, plantComponent);
        }
    }
}
