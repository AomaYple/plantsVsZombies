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

    anchors.centerIn: parent
    height: width / 402 * 479
    width: parent.width * 0.55

    Dialog {
        id: dialog

        closePolicy: Popup.CloseOnEscape
        height: parent.height
        modal: true
        width: parent.width

        background: Image {
            asynchronous: true
            mipmap: true
            source: '../../resources/scenes/optionsMenuBackground.png'
            sourceSize: Qt.size(width, height)
        }

        onClosed: root.backToGame()

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            asynchronous: true
            height: width / 291 * 109
            mipmap: true
            source: '../../resources/scenes/button.png'
            sourceSize: Qt.size(width, height)
            width: parent.width * 0.45
            y: parent.height * 0.62

            Text {
                anchors.centerIn: parent
                color: '#008000'
                text: '主菜单'

                font {
                    bold: true
                    pointSize: height > 0 ? height * 9 : 1
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
            height: width / 341 * 79
            mipmap: true
            source: '../../resources/scenes/optionsMenuButton.png'
            sourceSize: Qt.size(width, height)
            width: parent.width * 0.85
            y: parent.height * 0.82

            Text {
                anchors.centerIn: parent
                color: '#008000'
                text: '返回游戏'

                font {
                    bold: true
                    pointSize: height > 0 ? height * 14 : 1
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
