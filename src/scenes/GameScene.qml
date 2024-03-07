import QtQuick

Item {
    id: root

    signal backToMainMenu
    signal chose
    signal started

    enabled: false

    DaytimeGrass {
        onFinished: {
            readySetPlant.start();
            seedBank.emerge();
            parent.chose();
        }
    }
    MouseArea {
        anchors.fill: parent
        enabled: shovelBank.shoveling
        hoverEnabled: true

        onPositionChanged: {
            shovel.x = mouseX - shovel.width / 2;
            shovel.y = mouseY - shovel.height / 2;
        }
    }
    ReadySetPlant {
        id: readySetPlant

        onFinished: {
            parent.enabled = true;
            menuButton.forceActiveFocus();
            parent.started();
        }
    }
    SeedBank {
        id: seedBank

    }
    ShovelBank {
        id: shovelBank

        anchors.left: seedBank.right

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
    MenuButton {
        id: menuButton

        onTriggered: {
            parent.enabled = false;
            menuDialog.open();
        }
    }
    MenuDialog {
        id: menuDialog

        onBackToGame: {
            close();
            menuButton.forceActiveFocus();
            parent.enabled = true;
        }
        onBackToMainMenu: {
            close();
            parent.backToMainMenu();
        }
    }
    SunlightProducer {
        onCollected: seedBank.increaseSunlight()
    }
    PlantArea {
        gameScene: parent
    }
}
