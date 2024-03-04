import QtQuick

Item {
    id: root

    signal backToMainMenu
    signal chose
    signal started

    clip: true

    Image {
        id: background

        asynchronous: true
        height: parent.height
        mipmap: true
        source: '../../resources/scenes/daytimeGrass.png'
        sourceSize: Qt.size(width, height)
        width: height / 600 * 1400

        onStatusChanged: if (status === Image.Ready)
            pauseView.start()

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
        height: parent.height * 0.3
        width: height / 99 * 210

        onFinished: {
            shovelBank.visible = menuButton.visible = true;
            menuButton.forceActiveFocus();
            root.started();
        }
    }

    SeedBank {
        id: seedBank

        height: parent.height * 0.15
        width: height / 87 * 446
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
        height: parent.height * 0.12
        visible: false
        width: height / 72 * 70
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

        anchors.right: parent.right
        height: parent.height * 0.07
        visible: false
        width: height / 109 * 291
        y: 0

        onTriggered: menuDialog.open()
    }

    MenuDialog {
        id: menuDialog

        anchors.centerIn: parent
        height: parent.height * 0.8
        width: height / 476 * 402

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
