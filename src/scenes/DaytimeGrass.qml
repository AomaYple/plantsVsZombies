import QtQuick

Item {
    id: root

    signal backToMainMenu
    signal chose
    signal started

    clip: true

    Image {
        id: background

        property list<QtObject> previewZombies

        function createPreviewZombies() {
            const component = Qt.createComponent('BasicZombieStand.qml');
            previewZombies.push(component.createObject(background, {
                height: background.height * 0.1,
                width: height / 126 * 84,
                x: background.width * 0.7,
                y: background.height * 0.3
            }));
            previewZombies.push(component.createObject(background, {
                height: background.height * 0.1,
                width: height / 126 * 84,
                x: background.width * 0.75,
                y: background.height * 0.5
            }));
            previewZombies.push(component.createObject(background, {
                height: background.height * 0.1,
                width: height / 126 * 84,
                x: background.width * 0.73,
                y: background.height * 0.7
            }));
            previewZombies.push(component.createObject(background, {
                height: background.height * 0.1,
                width: height / 126 * 84,
                x: background.width * 0.77,
                y: background.height * 0.9
            }));
        }
        function destroyPreviewZombies() {
            for (let i = 0; i < previewZombies.length; ++i)
                previewZombies[i].destroy();
            previewZombies = [];
        }

        asynchronous: true
        height: parent.height
        mipmap: true
        source: '../../resources/scenes/daytimeGrass.png'
        sourceSize: Qt.size(width, height)
        width: height / 600 * 1400

        onStatusChanged: if (status === Image.Ready) {
            pauseView.start();
            createPreviewZombies();
        }

        Timer {
            id: pauseView

            interval: 1500

            onTriggered: leftRightMove.start()
        }
        XAnimator {
            id: leftRightMove

            duration: 2000
            target: background
            to: root.width - background.width

            onFinished: {
                if (to === root.width - background.width) {
                    to = -background.width * 0.157;
                    pauseView.start();
                } else {
                    readySetPlant.start();
                    seedBankEmerge.start();
                    background.destroyPreviewZombies();
                    root.chose();
                }
            }
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

        YAnimator {
            id: seedBankEmerge

            duration: 500
            target: seedBank
            to: 0
        }
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
