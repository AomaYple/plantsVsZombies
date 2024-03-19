import QtQuick
import QtMultimedia

Image {
    id: image

    required property bool paused
    property Seed plantingSeed: null

    function emerge() {
        yAnimator.start();
    }

    function increaseSunlight() {
        sunlightSum.increase();
    }

    function plant() {
        sunlightSum.decrease(plantingSeed.sunlightConsumption);
        plantingSeed.plant();
        plantingSeed = null;
    }

    asynchronous: true
    enabled: false
    mipmap: true
    source: '../../resources/scenes/seedBank.png'
    sourceSize: Qt.size(width, height)
    width: height / 87 * 446
    y: -height

    onPlantingSeedChanged: {
        if (plantingSeed)
            seedLift.play();
    }

    Text {
        id: sunlightSum

        function decrease(value) {
            text = (parseInt(text) - value).toString();
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

        anchors.verticalCenter: parent.verticalCenter
        cooldownTime: 7500
        enabled: parent.enabled && (!parent.plantingSeed || planting)
        height: parent.height * 0.84
        paused: parent.paused
        plantComponent: Qt.createComponent('../plants/Sunflower.qml', Component.Asynchronous)
        previewPlantSource: '../../resources/plants/sunflower.png'
        source: '../../resources/plants/sunflowerSeed.png'
        sunlightConsumption: 50
        sunlightSum: sunlightSum.sum()
        x: parent.width * 0.17

        onBuzzered: buzzer.play()
        onPlantingChanged: {
            if (planting)
                parent.plantingSeed = sunflowerSeed;
            else
                parent.plantingSeed = null;
        }
    }

    Seed {
        id: peaShooterSeed

        cooldownTime: 7500
        enabled: parent.enabled && (!parent.plantingSeed || planting)
        height: parent.height * 0.84
        paused: parent.paused
        plantComponent: Qt.createComponent('../plants/PeaShooter.qml', Component.Asynchronous)
        previewPlantSource: '../../resources/plants/peaShooter.png'
        source: '../../resources/plants/peaShooterSeed.png'
        sunlightConsumption: 100
        sunlightSum: sunlightSum.sum()

        onBuzzered: buzzer.play()
        onPlantingChanged: {
            if (planting)
                parent.plantingSeed = peaShooterSeed;
            else
                parent.plantingSeed = null;
        }

        anchors {
            left: sunflowerSeed.right
            verticalCenter: parent.verticalCenter
        }
    }

    Seed {
        id: wallNutSeed

        cooldownTime: 30000
        enabled: parent.enabled && (!parent.plantingSeed || planting)
        height: parent.height * 0.84
        paused: parent.paused
        plantComponent: Qt.createComponent('../plants/WallNut.qml', Component.Asynchronous)
        previewPlantSource: '../../resources/plants/wallNut.png'
        source: '../../resources/plants/wallNutSeed.png'
        sunlightConsumption: 50
        sunlightSum: sunlightSum.sum()

        onBuzzered: buzzer.play()
        onPlantingChanged: {
            if (planting)
                parent.plantingSeed = wallNutSeed;
            else
                parent.plantingSeed = null;
        }

        anchors {
            left: peaShooterSeed.right
            verticalCenter: parent.verticalCenter
        }
    }

    Seed {
        id: snowPeaShooterSeed

        cooldownTime: 7500
        enabled: parent.enabled && (!parent.plantingSeed || planting)
        height: parent.height * 0.84
        paused: parent.paused
        plantComponent: Qt.createComponent('../plants/SnowPeaShooter.qml', Component.Asynchronous)
        previewPlantSource: '../../resources/plants/snowPeaShooter.png'
        source: '../../resources/plants/snowPeaShooterSeed.png'
        sunlightConsumption: 175
        sunlightSum: sunlightSum.sum()

        onBuzzered: buzzer.play()
        onPlantingChanged: {
            if (planting)
                parent.plantingSeed = snowPeaShooterSeed;
            else
                parent.plantingSeed = null;
        }

        anchors {
            left: wallNutSeed.right
            verticalCenter: parent.verticalCenter
        }
    }

    Seed {
        id: repeaterSeed

        cooldownTime: 7500
        enabled: parent.enabled && (!parent.plantingSeed || planting)
        height: parent.height * 0.84
        paused: parent.paused
        plantComponent: Qt.createComponent('../plants/Repeater.qml', Component.Asynchronous)
        previewPlantSource: '../../resources/plants/repeater.png'
        source: '../../resources/plants/repeaterSeed.png'
        sunlightConsumption: 200
        sunlightSum: sunlightSum.sum()

        onBuzzered: buzzer.play()
        onPlantingChanged: {
            if (planting)
                parent.plantingSeed = repeaterSeed;
            else
                parent.plantingSeed = null;
        }

        anchors {
            left: snowPeaShooterSeed.right
            verticalCenter: parent.verticalCenter
        }
    }

    Seed {
        id: potatoMineSeed

        cooldownTime: 30000
        enabled: parent.enabled && (!parent.plantingSeed || planting)
        height: parent.height * 0.84
        paused: parent.paused
        plantComponent: Qt.createComponent('../plants/PotatoMine.qml', Component.Asynchronous)
        previewPlantSource: '../../resources/plants/potatoMine.png'
        source: '../../resources/plants/potatoMineSeed.png'
        sunlightConsumption: 25
        sunlightSum: sunlightSum.sum()

        onBuzzered: buzzer.play()
        onPlantingChanged: {
            if (planting)
                parent.plantingSeed = potatoMineSeed;
            else
                parent.plantingSeed = null;
        }

        anchors {
            left: repeaterSeed.right
            verticalCenter: parent.verticalCenter
        }
    }
}
