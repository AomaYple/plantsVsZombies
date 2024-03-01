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

    Dialog {
        id: dialog

        closePolicy: Popup.CloseOnEscape
        height: parent.height
        modal: true
        width: parent.width

        background: Image {
            mipmap: true
            source: '../../resources/scenes/optionsMenuBackground.png'
            sourceSize: Qt.size(width, height)
        }

        onClosed: root.backToGame()

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height * 0.15
            mipmap: true
            source: '../../resources/scenes/button.png'
            sourceSize: Qt.size(width, height)
            width: height / 109 * 291
            y: parent.height * 0.62

            Text {
                anchors.centerIn: parent
                color: '#008000'
                text: '主菜单'

                font {
                    bold: true
                    pointSize: height > 0 ? height * 14 : 1
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
            height: parent.height * 0.17
            mipmap: true
            source: '../../resources/scenes/optionsMenuButton.png'
            sourceSize: Qt.size(width, height)
            width: height / 79 * 341
            y: parent.height * 0.82

            Text {
                anchors.centerIn: parent
                color: '#008000'
                text: '返回游戏'

                font {
                    bold: true
                    pointSize: height > 0 ? height * 23 : 1
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
