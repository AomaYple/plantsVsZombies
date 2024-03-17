import QtQuick
import QtMultimedia

Image {
    id: image

    required property bool paused
    property var plantComponent: null
    property url previewPlantSource: ''

    function cancelPlant() {
        plantComponent = null;
        previewPlantSource = '';
    }

    function emerge() {
        yAnimator.running = true;
    }

    function increaseSunlight() {
        sunlightSum.increase();
    }

    function plant() {
        cancelPlant();
        sunflowerSeed.plant();
        peaShooterSeed.plant();
        wallNutSeed.plant();
        snowPeaShooterSeed.plant();
        sunlightSum.decrease();
    }

    function startPlant(seedPreviewPlantSource, seedPlantComponent, seedSunlightConsumption) {
        previewPlantSource = seedPreviewPlantSource;
        plantComponent = seedPlantComponent;
        sunlightSum.sunlightConsumption = seedSunlightConsumption;
        seedLift.play();
    }

    asynchronous: true
    enabled: false
    mipmap: true
    source: '../../resources/scenes/seedBank.png'
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
        text: '5000'
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
        target: image
        to: 0
    }

    SoundEffect {
        id: seedLift

        source: '../../resources/sounds/seedLift.wav'
    }

    SoundEffect {
        id: buzzer

        source: '../../resources/sounds/buzzer.wav'
    }

    Seed {
        id: sunflowerSeed

        readonly property var plantComponent: Qt.createComponent('../plants/Sunflower.qml', Component.Asynchronous)
        readonly property url previewPlantSource: '../../resources/plants/sunflower.png'

        anchors.verticalCenter: parent.verticalCenter
        cooldownTime: 7500
        enabled: parent.enabled && (!parent.planting || planting)
        height: parent.height * 0.84
        paused: parent.paused
        source: '../../resources/plants/sunflowerSeed.png'
        sunlightConsumption: 50
        sunlightSum: sunlightSum.sum()
        x: parent.width * 0.17

        onBuzzered: buzzer.play()
        onPlantCanceled: parent.cancelPlant()
        onPlantStarted: parent.startPlant(previewPlantSource, plantComponent, sunlightConsumption)
    }

    Seed {
        id: peaShooterSeed

        readonly property var plantComponent: Qt.createComponent('../plants/PeaShooter.qml', Component.Asynchronous)
        readonly property url previewPlantSource: '../../resources/plants/peaShooter.png'

        cooldownTime: 7500
        enabled: parent.enabled && (!parent.planting || planting)
        height: sunflowerSeed.height
        paused: parent.paused
        source: '../../resources/plants/peaShooterSeed.png'
        sunlightConsumption: 100
        sunlightSum: sunlightSum.sum()

        onBuzzered: buzzer.play()
        onPlantCanceled: parent.cancelPlant()
        onPlantStarted: parent.startPlant(previewPlantSource, plantComponent, sunlightConsumption)

        anchors {
            left: sunflowerSeed.right
            verticalCenter: parent.verticalCenter
        }
    }

    Seed {
        id: wallNutSeed

        readonly property var plantComponent: Qt.createComponent('../plants/WallNut.qml', Component.Asynchronous)
        readonly property url previewPlantSource: '../../resources/plants/wallNut.png'

        cooldownTime: 30000
        enabled: parent.enabled && (!parent.planting || planting)
        height: peaShooterSeed.height
        paused: parent.paused
        source: '../../resources/plants/wallNutSeed.png'
        sunlightConsumption: 50
        sunlightSum: sunlightSum.sum()

        onBuzzered: buzzer.play()
        onPlantCanceled: parent.cancelPlant()
        onPlantStarted: parent.startPlant(previewPlantSource, plantComponent, sunlightConsumption)

        anchors {
            left: peaShooterSeed.right
            verticalCenter: parent.verticalCenter
        }
    }

    Seed {
        id: snowPeaShooterSeed

        readonly property var plantComponent: Qt.createComponent('../plants/SnowPeaShooter.qml', Component.Asynchronous)
        readonly property url previewPlantSource: '../../resources/plants/snowPeaShooter.png'

        cooldownTime: 7500
        enabled: parent.enabled && (!parent.planting || planting)
        height: sunflowerSeed.height
        paused: parent.paused
        source: '../../resources/plants/snowPeaShooterSeed.png'
        sunlightConsumption: 175
        sunlightSum: sunlightSum.sum()

        onBuzzered: buzzer.play()
        onPlantCanceled: parent.cancelPlant()
        onPlantStarted: parent.startPlant(previewPlantSource, plantComponent, sunlightConsumption)

        anchors {
            left: wallNutSeed.right
            verticalCenter: parent.verticalCenter
        }
    }
}
