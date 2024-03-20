import QtQuick
import QtMultimedia
import "../plants" as Plants
import "../zombies" as Zombies
import "../js/common.js" as Common

Item {
    id: item

    signal backToMainMenu
    signal chose
    signal started

    function playChomp() {
        const index = Common.getRandomInt(0, 2);
        switch (index) {
        case 0:
            chomp0.play();
            break;
        case 1:
            chomp1.play();
            break;
        case 2:
            chomp2.play();
            break;
        }
    }

    function playShieldHit() {
        const index = Math.round(Math.random());
        switch (index) {
        case 0:
            shieldHit0.play();
            break;
        case 1:
            shieldHit1.play();
            break;
        }
    }

    function playSplat() {
        const index = Common.getRandomInt(0, 2);
        switch (index) {
        case 0:
            splat0.play();
            break;
        case 1:
            splat1.play();
            break;
        case 2:
            splat2.play();
            break;
        }
    }

    function stopChomp() {
        chomp0.stop();
        chomp1.stop();
        chomp2.stop();
    }

    Image {
        id: image

        readonly property Component diedZombieComponent: Qt.createComponent('../zombies/DiedZombie.qml', Component.Asynchronous)
        readonly property real leftMargin: width * 0.157
        readonly property Component mashedPotatoComponent: Qt.createComponent('../plants/MashedPotato.qml', Component.Asynchronous)
        property bool paused: true
        readonly property Component peaComponent: Qt.createComponent('../plants/Pea.qml', Component.Asynchronous)
        readonly property real rightMargin: width - leftMargin - parent.width
        readonly property Component snowPeaComponent: Qt.createComponent('../plants/SnowPea.qml', Component.Asynchronous)
        readonly property Component standingBasicZombieComponent: Qt.createComponent('../zombies/StandingBasicZombie.qml')
        readonly property Component standingBucketHeadZombie: Qt.createComponent('../zombies/StandingBucketHeadZombie.qml')
        readonly property Component standingConeHeadZombie: Qt.createComponent('../zombies/StandingConeHeadZombie.qml')

        asynchronous: true
        height: parent.height
        mipmap: true
        source: '../../resources/scenes/daytimeGrass.png'
        sourceSize: Qt.size(width, height)
        width: height / 600 * 1400

        onStatusChanged: if (status === Image.Ready) {
            Common.produceStandingZombies();
            timer.start();
        }

        ReadySetPlant {
            id: readySetPlant

            anchors.verticalCenter: parent.verticalCenter
            height: parent.height * 0.2
            x: (item.width - width) / 2 + parent.leftMargin

            onFinished: {
                menuButton.visible = shovelBank.visible = true;
                menuButton.forceActiveFocus();
                mouseArea.enabled = Qt.binding(function () {
                    return seedBank.plantingSeed || shovelBank.shoveling;
                });
                seedBank.enabled = Qt.binding(function () {
                    return !shovelBank.shoveling;
                });
                sunlightProducer.start();
                zombieProducer.start();
                parent.paused = false;
                item.started();
            }
        }

        MouseArea {
            id: mouseArea

            anchors.fill: parent
            enabled: false
            hoverEnabled: true

            onPositionChanged: {
                if (seedBank.plantingSeed) {
                    previewPlant.x = mouseX - previewPlant.width / 2;
                    previewPlant.y = mouseY - previewPlant.height / 2;
                } else {
                    shovel.x = mouseX - shovel.width / 2;
                    shovel.y = mouseY - shovel.height / 2;
                }
            }

            SeedBank {
                id: seedBank

                height: parent.height * 0.145
                paused: image.paused
                x: image.leftMargin + parent.width * 0.01

                onPlantingSeedChanged: {
                    if (plantingSeed)
                        previewPlant.source = plantArea.previewPlantSource = plantingSeed.previewPlantSource;
                    else
                        previewPlant.source = plantArea.previewPlantSource = '';
                }
            }

            ShovelBank {
                id: shovelBank

                function fixShovel() {
                    shoveling = false;
                    shovel.x = x + (width - shovel.width) / 2;
                    shovel.y = y + (height - shovel.height) / 2;
                }

                anchors.left: seedBank.right
                enabled: !seedBank.plantingSeed
                height: parent.height * 0.13

                onClicked: if (shoveling)
                    fixShovel()
                else
                    shoveling = true
            }

            PlantArea {
                id: plantArea

                shoveling: shovelBank.shoveling
                subPlantAreaSize: Qt.size(item.width * 0.105, parent.height * 0.16)
                x: image.leftMargin + parent.width * 0.018
                y: parent.height * 0.145

                onPlanted: (property, subPlantArea) => Common.plant(property, subPlantArea)
                onShovelled: shovelBank.fixShovel()
            }
        }

        ZombieProducer {
            id: zombieProducer

            paused: running && parent.paused

            onTriggered: Common.produceZombie(zombieComponent)
        }

        SunlightProducer {
            id: sunlightProducer

            paused: running && parent.paused

            onTriggered: {
                const sunlightHeight = parent.height * 0.14;
                const beginPosition = Qt.point(Common.getRandomFloat(image.leftMargin, parent.width - image.rightMargin - sunlightHeight), seedBank.height);
                const endPositionY = Common.getRandomFloat(seedBank.height + parent.height * 0.1, parent.height - sunlightHeight);
                Common.produceSunlight(beginPosition, endPositionY, true);
            }
        }

        PreviewPlant {
            id: previewPlant

            height: parent.height * 0.15
        }

        Shovel {
            id: shovel

            height: shovelBank.height * 0.8
            visible: shovelBank.visible
            x: shovelBank.x + (shovelBank.width - width) / 2
            y: shovelBank.y + (shovelBank.height - height) / 2
        }

        MenuButton {
            id: menuButton

            height: parent.height * 0.07
            x: parent.width - image.rightMargin - width

            onTriggered: {
                parent.paused = true;
                menuDialog.open();
            }
        }

        MenuDialog {
            id: menuDialog

            height: parent.height * 0.8
            x: (item.width - width) / 2 + parent.leftMargin
            y: (parent.height - height) / 2

            onBackToGame: {
                close();
                menuButton.forceActiveFocus();
                parent.paused = false;
            }
            onBackToMainMenu: {
                close();
                item.backToMainMenu();
            }
        }
    }

    Timer {
        id: timer

        interval: 1500

        onTriggered: moveAnimator.start()
    }

    XAnimator {
        id: moveAnimator

        signal readied

        duration: 2000
        target: image
        to: item.width - image.width

        onFinished: {
            if (to === item.width - image.width) {
                to = -image.leftMargin;
                timer.start();
            } else {
                readySetPlant.start();
                seedBank.emerge();
                readied();
                item.chose();
            }
        }
    }

    XAnimator {
        id: judderAnimator

        readonly property real gap: -image.height * 0.01

        duration: 200
        target: image
        to: gap - image.leftMargin

        onFinished: if (to === gap - image.leftMargin) {
            to = -image.leftMargin;
            start();
        } else
            to = gap - image.leftMargin
    }

    YAnimator {
        duration: judderAnimator.duration
        running: judderAnimator.running
        target: image
        to: judderAnimator.gap

        onFinished: if (to === judderAnimator.gap)
            to = 0
        else
            to = judderAnimator.gap
    }

    SoundEffect {
        id: points

        source: '../../resources/sounds/points.wav'
    }

    SoundEffect {
        id: splat0

        source: '../../resources/sounds/splat0.wav'
    }

    SoundEffect {
        id: splat1

        source: '../../resources/sounds/splat1.wav'
    }

    SoundEffect {
        id: splat2

        source: '../../resources/sounds/splat2.wav'
    }

    SoundEffect {
        id: shieldHit0

        source: '../../resources/sounds/shieldHit0.wav'
    }

    SoundEffect {
        id: shieldHit1

        source: '../../resources/sounds/shieldHit1.wav'
    }

    SoundEffect {
        id: potatoMineBomb

        source: '../../resources/sounds/potatoMine.wav'
    }

    SoundEffect {
        id: frozen

        source: '../../resources/sounds/frozen.wav'
    }

    SoundEffect {
        id: chomp0

        loops: SoundEffect.Infinite
        source: '../../resources/sounds/chomp0.wav'
    }

    SoundEffect {
        id: chomp1

        loops: SoundEffect.Infinite
        source: '../../resources/sounds/chomp1.wav'
    }

    SoundEffect {
        id: chomp2

        loops: SoundEffect.Infinite
        source: '../../resources/sounds/chomp2.wav'
    }

    SoundEffect {
        id: gulp

        source: '../../resources/sounds/gulp.wav'
    }
}
