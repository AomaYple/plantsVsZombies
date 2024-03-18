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

    Image {
        id: image

        readonly property real leftMargin: width * 0.157
        property bool paused: true
        readonly property real rightMargin: width - leftMargin - parent.width

        function judder() {
            judderAnimator.running = true;
        }

        asynchronous: true
        height: parent.height
        mipmap: true
        source: '../../resources/scenes/daytimeGrass.png'
        sourceSize: Qt.size(width, height)
        width: height / 600 * 1400

        onStatusChanged: if (status === Image.Ready) {
            timer.running = true;
            for (let i = 0; i < 9; ++i) {
                let zombieStandComponent = null, zombieHeight = null, zombieWidth = null;
                if (i < 4) {
                    zombieStandComponent = Qt.createComponent('../zombies/BasicZombieStand.qml');
                    zombieHeight = image.height * 0.23;
                    zombieWidth = zombieHeight / 126 * 84;
                } else if (i >= 4 && i < 7) {
                    zombieStandComponent = Qt.createComponent('../zombies/ConeHeadZombieStand.qml');
                    zombieHeight = image.height * 0.25;
                    zombieWidth = zombieHeight / 148 * 82;
                } else {
                    zombieStandComponent = Qt.createComponent('../zombies/BucketHeadZombieStand.qml');
                    zombieHeight = image.height * 0.24;
                    zombieWidth = zombieHeight / 140 * 84;
                }
                const incubator = zombieStandComponent.incubateObject(image, {
                    width: Qt.binding(function () {
                        return zombieWidth;
                    }),
                    height: Qt.binding(function () {
                        return zombieHeight;
                    }),
                    x: Qt.binding(function () {
                        return Common.getRandomFloat(image.width - image.rightMargin, image.width - zombieWidth);
                    }),
                    y: Qt.binding(function () {
                        return Common.getRandomFloat(0, image.height - zombieHeight);
                    })
                });
                function destroyZombieStand() {
                    incubator.object.destroy();
                    moveAnimator.readied.disconnect(destroyZombieStand);
                }
                moveAnimator.readied.connect(destroyZombieStand);
            }
        }

        Timer {
            id: timer

            interval: 1500

            onTriggered: moveAnimator.running = true
        }

        XAnimator {
            id: moveAnimator

            signal readied

            duration: 2000
            target: image
            to: -(image.leftMargin + image.rightMargin)

            onFinished: {
                if (to === -(image.leftMargin + image.rightMargin)) {
                    to = -image.leftMargin;
                    timer.running = true;
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
            to: -image.leftMargin + gap

            onFinished: if (to === -image.leftMargin + gap) {
                running = true;
                to = -image.leftMargin;
            } else
                to = -image.leftMargin + gap
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

        ReadySetPlant {
            id: readySetPlant

            anchors.verticalCenter: parent.verticalCenter
            height: parent.height * 0.2
            x: (parent.width - parent.leftMargin - parent.rightMargin - width) / 2 + parent.leftMargin

            onFinished: {
                menuButton.visible = shovelBank.visible = sunlightProducer.running = zombieProducer.running = true;
                menuButton.forceActiveFocus();
                parent.paused = false;
                mouseArea.enabled = Qt.binding(function () {
                    return seedBank.plantComponent || shovelBank.shoveling;
                });
                seedBank.enabled = Qt.binding(function () {
                    return !shovelBank.shoveling;
                });
                item.started();
            }
        }

        SunlightProducer {
            id: sunlightProducer

            paused: running && parent.paused

            onTriggered: Common.naturalGenerateSunlight()
        }

        ZombieProducer {
            id: zombieProducer

            paused: running && parent.paused

            onTriggered: Common.createZombie()
        }

        MouseArea {
            id: mouseArea

            anchors.fill: parent
            enabled: false
            hoverEnabled: true

            onPositionChanged: {
                if (seedBank.plantComponent) {
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
            }

            ShovelBank {
                id: shovelBank

                function fixShovel() {
                    shoveling = false;
                    shovel.x = x + (width - shovel.width) / 2;
                    shovel.y = y + (height - shovel.height) / 2;
                }

                anchors.left: seedBank.right
                enabled: !seedBank.plantComponent
                height: parent.height * 0.13

                onClicked: if (shoveling)
                    fixShovel()
                else
                    shoveling = true
            }

            PlantArea {
                id: plantArea

                previewPlantSource: previewPlant.source
                shoveling: shovelBank.shoveling
                subPlantAreaSize: Qt.size((parent.width - image.leftMargin - image.rightMargin) * 0.105, parent.height * 0.16)
                x: image.leftMargin + parent.width * 0.018
                y: parent.height * 0.145

                onPlanted: (property, subPlantAreaId) => Common.plant(property, subPlantAreaId)
                onShovelled: shovelBank.fixShovel()
            }
        }

        PreviewPlant {
            id: previewPlant

            height: parent.height * 0.15
            source: seedBank.previewPlantSource
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
            x: parent.width - parent.rightMargin - width

            onTriggered: {
                parent.paused = true;
                menuDialog.visible = true;
            }
        }

        MenuDialog {
            id: menuDialog

            height: parent.height * 0.8
            x: (parent.width - parent.leftMargin - parent.rightMargin - width) / 2 + parent.leftMargin
            y: (parent.height - height) / 2

            onBackToGame: {
                visible = false;
                parent.paused = false;
                menuButton.forceActiveFocus();
            }
            onBackToMainMenu: {
                visible = false;
                item.backToMainMenu();
            }
        }
    }
}
