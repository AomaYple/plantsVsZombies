import QtQuick
import "../plants" as Plants
import "../js/common.js" as Common

Item {
    id: root

    property bool paused: true

    signal backToMainMenu
    signal chose
    signal started

    DaytimeGrass {
        anchors.fill: parent

        onFinished: {
            readySetPlant.start();
            seedBank.emerge();
            parent.chose();
        }
    }
    ReadySetPlant {
        id: readySetPlant

        height: parent.height * 0.2

        onFinished: {
            menuButton.visible = shovelBank.visible = true;
            seedBank.enabled = Qt.binding(function () {
                return !shovelBank.shoveling;
            });
            parent.paused = false;
            menuButton.forceActiveFocus();
            parent.started();
        }
    }
    PlantArea {
        id: plantArea

        gameSceneSize: Qt.size(parent.width, parent.height)
        x: parent.width * 0.025
        y: parent.height * 0.142
    }
    MouseArea {
        anchors.fill: parent
        enabled: seedBank.planting || shovelBank.shoveling
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
            parent.paused = false;
            menuButton.forceActiveFocus();
        }
        onBackToMainMenu: {
            close();
            parent.backToMainMenu();
        }
    }
    SeedBank {
        id: seedBank

        height: parent.height * 0.145
        paused: parent.paused
        x: parent.width * 0.01

        onPlantCanceled: {
            previewPlant.source = '';
            plantArea.plantComponent = null;
        }
        onPlantStarted: (previewPlantSource, plantComponent) => {
            previewPlant.source = previewPlantSource;
            plantArea.plantComponent = plantComponent;
        }
    }
    ShovelBank {
        id: shovelBank

        anchors.left: seedBank.right
        enabled: !seedBank.planting
        height: parent.height * 0.13

        onClicked: {
            if (shoveling) {
                shoveling = false;
                shovel.x = x + (width - shovel.width) / 2;
                shovel.y = y + (height - shovel.height) / 2;
            } else
                shoveling = true;
        }
    }
    Shovel {
        id: shovel

        height: shovelBank.height * 0.8
        visible: shovelBank.visible
        x: shovelBank.x + (shovelBank.width - width) / 2
        y: shovelBank.y + (shovelBank.height - height) / 2
    }
    Plants.PreviewPlant {
        id: previewPlant

        function plant() {
            source = '';
            plantComponent = null;
            seedBank.plant();
        }

        height: parent.height * 0.15
    }
    SunlightProducer {
        id: sunlightProducer

        running: !parent.paused

        onTriggered: Common.naturalGenerateSunlight()
    }
}
