import QtQuick

Item {
    id: root

    property bool paused: true

    signal backToMainMenu
    signal chose
    signal started

    DaytimeGrass {
        onFinished: {
            readySetPlant.start();
            seedBank.emerge();
            parent.chose();
        }
    }
    MouseArea {
        id: globalMouseArea

        anchors.fill: parent
        hoverEnabled: true

        onPositionChanged: if (shovelBank.shoveling) {
            shovel.x = mouseX - shovel.width / 2;
            shovel.y = mouseY - shovel.height / 2;
        }
    }
    ReadySetPlant {
        id: readySetPlant

        onFinished: {
            shovelBank.visible = menuButton.visible = plantArea.enabled = true;
            menuButton.forceActiveFocus();
            parent.paused = false;
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
    Image {
        id: shovel

        asynchronous: true
        height: shovelBank.height * 0.8
        mipmap: true
        source: '../../resources/scenes/shovel.png'
        sourceSize: Qt.size(width, height)
        visible: shovelBank.visible
        width: height / 63 * 59
        x: shovelBank.x + (shovelBank.width - width) / 2
        y: shovelBank.y + (shovelBank.height - height) / 2
    }
    MenuButton {
        id: menuButton

        onTriggered: {
            parent.paused = true;
            menuDialog.open();
        }
    }
    MenuDialog {
        id: menuDialog

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
    SunlightProducer {
        onCollected: seedBank.increaseSunlight()
    }
    PlantArea {
        id: plantArea

        gameScene: parent
    }
}
