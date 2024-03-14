import QtQuick
import "../plants" as Plants
import "../js/common.js" as Common

Item {
    id: root

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
        source: rootPath + '/resources/scenes/daytimeGrass.png'
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
                    root.chose();
                }
            }
        }
        ReadySetPlant {
            id: readySetPlant

            anchors.verticalCenter: parent.verticalCenter
            height: parent.height * 0.2
            x: (parent.width - parent.leftMargin - parent.rightMargin - width) / 2 + parent.leftMargin

            onFinished: {
                menuButton.visible = shovelBank.visible = true;
                shovelBank.shoveling = parent.paused = false;
                sunlightProducer.running = zombieProducer.running = true;
                menuButton.forceActiveFocus();
                root.started();
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
            anchors.fill: parent
            enabled: !parent.paused && (seedBank.planting || shovelBank.shoveling)
            hoverEnabled: true

            onPositionChanged: {
                if (seedBank.planting) {
                    previewPlant.x = mouseX - previewPlant.width / 2;
                    previewPlant.y = mouseY - previewPlant.height / 2;
                } else if (shovelBank.shoveling) {
                    shovel.x = mouseX - shovel.width / 2;
                    shovel.y = mouseY - shovel.height / 2;
                }
            }

            SeedBank {
                id: seedBank

                enabled: !shovelBank.shoveling
                height: parent.height * 0.145
                paused: image.paused
                x: image.leftMargin + parent.width * 0.01

                onPlantCanceled: {
                    previewPlant.source = '';
                    previewPlant.plantComponent = null;
                }
                onPlantStarted: (previewPlantSource, plantComponent) => {
                    previewPlant.source = previewPlantSource;
                    previewPlant.plantComponent = plantComponent;
                }
            }
            ShovelBank {
                id: shovelBank

                function fixShovel() {
                    shovel.x = x + (width - shovel.width) / 2;
                    shovel.y = y + (height - shovel.height) / 2;
                    shoveling = false;
                }

                anchors.left: seedBank.right
                enabled: !seedBank.planting
                height: parent.height * 0.13

                onClicked: {
                    if (shoveling)
                        fixShovel();
                    else
                        shoveling = true;
                }
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
                    previewPlant.plant();
                }
            }
        }
        PreviewPlant {
            id: previewPlant

            property var plantComponent

            function plant() {
                source = '';
                plantComponent = null;
                seedBank.plant();
            }

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
                root.backToMainMenu();
            }
        }
    }
}
