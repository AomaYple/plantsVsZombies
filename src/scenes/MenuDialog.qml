import QtQuick
import QtQuick.Controls

Item {
    id: root

    signal backToGame
    signal backToMainMenu

    function close() {
        dialog.close();
    }
    function open() {
        dialog.open();
    }

    width: height / 479 * 402

    Dialog {
        id: dialog

        closePolicy: Popup.CloseOnEscape
        height: parent.height
        modal: true
        width: parent.width

        background: Image {
            asynchronous: true
            mipmap: true
            source: rootPath + '/resources/scenes/optionsMenuBackground.png'
            sourceSize: Qt.size(width, height)
        }

        onClosed: root.backToGame()

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            asynchronous: true
            height: parent.height * 0.15
            mipmap: true
            source: rootPath + '/resources/scenes/button.png'
            sourceSize: Qt.size(width, height)
            width: height / 109 * 291
            y: parent.height * 0.64

            Text {
                anchors.centerIn: parent
                color: '#008000'
                text: '主菜单'

                font {
                    bold: true
                    pointSize: Math.max(parent.height * 0.25, 1)
                }
            }
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: root.backToMainMenu()
            }
        }
        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            asynchronous: true
            height: parent.height * 0.18
            mipmap: true
            source: rootPath + '/resources/scenes/optionsMenuButton.png'
            sourceSize: Qt.size(width, height)
            width: height / 79 * 341
            y: parent.height * 0.84

            Text {
                anchors.centerIn: parent
                color: '#008000'
                text: '返回游戏'

                font {
                    bold: true
                    pointSize: Math.max(parent.height * 0.3, 1)
                }
            }
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: root.backToGame()
            }
        }
    }
}
