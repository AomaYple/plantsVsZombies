import QtQuick
import QtMultimedia
import "../plants" as Plants
import "../zombies" as Zombies
import "../js/common.js" as Common

Item {
    id: item

    property bool paused: true

    signal backToMainMenu
    signal chose
    signal started

    Image {
        id: image

        readonly property real areaY: height * 0.145
        readonly property size chunkSize: Qt.size(width * 0.06, height * 0.16)
        readonly property Component diedZombieComponent: Qt.createComponent('../zombies/DiedZombie.qml', Component.Asynchronous)
        readonly property real leftMargin: width * 0.157
        readonly property Component mashedPotatoComponent: Qt.createComponent('../plants/MashedPotato.qml', Component.Asynchronous)
        readonly property Component peaComponent: Qt.createComponent('../plants/Pea.qml', Component.Asynchronous)
        readonly property real rightMargin: width - leftMargin - parent.width
        readonly property Component snowPeaComponent: Qt.createComponent('../plants/SnowPea.qml', Component.Asynchronous)
        readonly property Component standingBasicZombieComponent: Qt.createComponent('../zombies/StandingBasicZombie.qml')
        readonly property Component standingBucketHeadZombie: Qt.createComponent('../zombies/StandingBucketHeadZombie.qml')
        readonly property Component standingConeHeadZombie: Qt.createComponent('../zombies/StandingConeHeadZombie.qml')

        function lose() {
            parent.paused = true;
            menuButton.enabled = menuButton.visible = mouseArea.enabled = seedBank.visible = shovelBank.visible = previewPlant.visible = false;
            hugeWave.stop();
            moveAnimator.to = 0;
            moveAnimator.start();
            loseSound.play();
            parent.chose();
        }

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
            to: -target.leftMargin - target.rightMargin

            onFinished: {
                if (to === -target.leftMargin - target.rightMargin) {
                    to = -target.leftMargin;
                    timer.start();
                } else if (to === -target.leftMargin) {
                    seedBank.emerge();
                    readied();
                }
            }
        }

        XAnimator {
            id: judderAnimator

            readonly property real gap: -target.height * 0.01

            duration: 200
            target: image
            to: gap - target.leftMargin

            onFinished: if (to === gap - target.leftMargin) {
                to = -target.leftMargin;
                start();
            } else
                to = gap - target.leftMargin
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
                paused: item.paused
                x: image.leftMargin + parent.width * 0.01

                onEmerged: cart4.emerge(image.leftMargin - cart4.width * 0.4)
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
                visible: menuButton.visible

                onClicked: if (shoveling)
                    fixShovel()
                else
                    shoveling = true
            }

            PlantArea {
                id: plantArea

                shoveling: shovelBank.shoveling
                subPlantAreaSize: image.chunkSize
                x: image.leftMargin + parent.width * 0.018
                y: image.areaY

                onPlanted: (property, subPlantArea) => Common.plant(property, subPlantArea)
                onShovelled: shovelBank.fixShovel()
            }
        }

        Cart {
            id: cart0

            height: parent.height * 0.1
            x: parent.leftMargin - width
            y: parent.areaY + parent.chunkSize.height - height

            onEmerged: {
                readySetPlant.start();
                item.chose();
            }
            onXChanged: {
                for (const zombie of zombieProducer.zombieContainer[0])
                    if (x + width >= zombie.x + zombie.width * 0.4 && x <= zombie.x + zombie.width)
                        zombie.die();
            }
        }

        Cart {
            id: cart1

            height: parent.height * 0.1
            x: parent.leftMargin - width
            y: parent.areaY + parent.chunkSize.height * 2 - height

            onEmerged: cart0.emerge(image.leftMargin - cart0.width * 0.4)
            onXChanged: {
                for (const zombie of zombieProducer.zombieContainer[1])
                    if (x + width >= zombie.x + zombie.width * 0.4 && x <= zombie.x + zombie.width)
                        zombie.die();
            }
        }

        Cart {
            id: cart2

            height: parent.height * 0.1
            x: parent.leftMargin - width
            y: parent.areaY + parent.chunkSize.height * 3 - height

            onEmerged: cart1.emerge(image.leftMargin - cart1.width * 0.4)
            onXChanged: {
                for (const zombie of zombieProducer.zombieContainer[2])
                    if (x + width >= zombie.x + zombie.width * 0.4 && x <= zombie.x + zombie.width)
                        zombie.die();
            }
        }

        Cart {
            id: cart3

            height: parent.height * 0.1
            x: parent.leftMargin - width
            y: parent.areaY + parent.chunkSize.height * 4 - height

            onEmerged: cart2.emerge(image.leftMargin - cart2.width * 0.4)
            onXChanged: {
                for (const zombie of zombieProducer.zombieContainer[3])
                    if (x + width >= zombie.x + zombie.width * 0.4 && x <= zombie.x + zombie.width)
                        zombie.die();
            }
        }

        Cart {
            id: cart4

            height: parent.height * 0.1
            x: parent.leftMargin - width
            y: parent.areaY + parent.chunkSize.height * 5 - height

            onEmerged: cart3.emerge(image.leftMargin - cart3.width * 0.4)
            onXChanged: {
                for (const zombie of zombieProducer.zombieContainer[4])
                    if (x + width >= zombie.x + zombie.width * 0.4 && x <= zombie.x + zombie.width)
                        zombie.die();
            }
        }

        ZombieProducer {
            id: zombieProducer

            paused: item.paused

            onHugeWaved: hugeWave.play()
            onTriggered: Common.produceZombie(zombieComponent)
        }

        SunlightProducer {
            id: sunlightProducer

            paused: item.paused

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

        SoundEffects {
            id: soundEffects

        }

        SoundEffect {
            id: loseSound

            source: '../../resources/sounds/loseSound.wav'

            onPlayingChanged: if (!playing) {
                zombieWon.start();
                soundEffects.playChomp();
            }
        }
    }

    ReadySetPlant {
        id: readySetPlant

        anchors.verticalCenter: parent.verticalCenter
        height: parent.height * 0.2
        x: (parent.width - width) / 2

        onFinished: {
            menuButton.visible = true;
            menuButton.forceActiveFocus();
            mouseArea.enabled = Qt.binding(function () {
                return seedBank.plantingSeed || shovelBank.shoveling;
            });
            seedBank.enabled = Qt.binding(function () {
                return !shovelBank.shoveling;
            });
            parent.paused = false;
            sunlightProducer.start();
            zombieProducer.start();
            parent.started();
        }
    }

    HugeWave {
        id: hugeWave

        anchors.centerIn: parent
        height: parent.height * 0.1
        paused: parent.paused
    }

    ZombieWon {
        id: zombieWon

        anchors.centerIn: parent
        height: parent.height * 0.8

        onZombieWon: parent.backToMainMenu()
    }

    MenuButton {
        id: menuButton

        anchors.right: parent.right
        height: parent.height * 0.07

        onTriggered: {
            parent.paused = true;
            menuDialog.open();
        }
    }

    MenuDialog {
        id: menuDialog

        height: parent.height * 0.8
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        onBackToGame: {
            close();
            menuButton.forceActiveFocus();
            parent.paused = false;
        }
        onBackToMainMenu: {
            close();
            parent.backToMainMenu();
        }
    }
}
