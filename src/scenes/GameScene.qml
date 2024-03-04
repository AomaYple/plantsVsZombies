import QtQuick

Item {
    id: root

    signal backToMainMenu
    signal chose
    signal started

    DaytimeGrass {
        anchors.fill: parent

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

        anchors.centerIn: parent
        width: parent.width * 0.7

        onFinished: {
            shovelBank.visible = menuButton.visible = true;
            menuButton.forceActiveFocus();
            root.started();
        }
    }
    SeedBank {
        id: seedBank

        width: parent.width * 0.6
        x: parent.width * 0.01
        y: -height
    }
    ShovelBank {
        id: shovelBank

        property bool shoveling: false

        anchors.left: seedBank.right
        visible: false
        width: parent.width * 0.09
        y: 0

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

        anchors.right: parent.right
        visible: false
        width: parent.width * 0.15
        y: 0

        onTriggered: menuDialog.open()
    }
    MenuDialog {
        id: menuDialog

        anchors.centerIn: parent
        width: parent.width * 0.55

        onBackToGame: {
            close();
            menuButton.forceActiveFocus();
        }
        onBackToMainMenu: {
            close();
            root.backToMainMenu();
        }
    }
}
