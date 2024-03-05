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
            root.chose();
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
            shovelBank.visible = menuButton.visible = true;
            menuButton.forceActiveFocus();
            parent.paused = false;
            root.started();
        }
    }
    SeedBank {
        id: seedBank

    }
    ShovelBank {
        id: shovelBank

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
        height: width / 59 * 63
        mipmap: true
        source: '../../resources/scenes/shovel.png'
        sourceSize: Qt.size(width, height)
        visible: shovelBank.visible
        width: shovelBank.width * 0.8
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
            root.backToMainMenu();
        }
    }
    Timer {
        id: sunlightTimer

        property list<QtObject> sunlights

        interval: 6000
        repeat: true
        running: !parent.paused

        onTriggered: sunlights.push(Qt.createComponent('Sunlight.qml').createObject(root))
    }
}
