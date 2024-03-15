import QtQuick
import "../plants" as Plants
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

        asynchronous: true
        height: parent.height
        mipmap: true
        source: '../../resources/scenes/daytimeGrass.png'
        sourceSize: Qt.size(width, height)
        width: height / 600 * 1400

        onStatusChanged: if (status === Image.Ready) {
            Common.createBasicZombieStand();
            timer.start();
        }

        Timer {
            id: timer

            interval: 1500

            onTriggered: xAnimator.start()
        }

        XAnimator {
            id: xAnimator

            signal readied

            duration: 2000
            target: image
            to: -(image.leftMargin + image.rightMargin)

            onFinished: {
                if (to === -(image.leftMargin + image.rightMargin)) {
                    to = -image.leftMargin;
                    timer.start();
                } else {
                    readied();
                    readySetPlant.start();
                    seedBank.emerge();
                    item.chose();
                }
            }
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
                    shovel.x = x + (width - shovel.width) / 2;
                    shovel.y = y + (height - shovel.height) / 2;
                }

                anchors.left: seedBank.right
                enabled: !seedBank.plantComponent
                height: parent.height * 0.13

                onClicked: if (!shoveling)
                    fixShovel()
            }

            PlantArea {
                id: plantArea

                previewPlantSource: previewPlant.source
                shoveling: shovelBank.shoveling
                subPlantAreaSize: Qt.size((parent.width - image.leftMargin - image.rightMargin) * 0.105, parent.height * 0.16)
                x: image.leftMargin + parent.width * 0.018
                y: parent.height * 0.145

                onEradicated: shovelBank.fixShovel()
                onPlanted: (properties, subPlantAreaId) => {
                    Common.plant(properties, subPlantAreaId);
                    seedBank.plant();
                }
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
                menuDialog.open();
            }
        }

        MenuDialog {
            id: menuDialog

            height: parent.height * 0.8
            x: (parent.width - parent.leftMargin - parent.rightMargin - width) / 2 + parent.leftMargin
            y: (parent.height - height) / 2

            onBackToGame: {
                close();
                parent.paused = false;
                menuButton.forceActiveFocus();
            }
            onBackToMainMenu: {
                close();
                item.backToMainMenu();
            }
        }
    }
}
