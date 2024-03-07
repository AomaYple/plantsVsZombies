import QtQuick
import QtQuick.Controls

Dialog {
    id: root

    signal backToGame
    signal backToMainMenu

    closePolicy: Popup.CloseOnEscape
    height: parent.height * 0.8
    modal: true
    width: height / 479 * 402
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2

    background: Image {
        asynchronous: true
        mipmap: true
        source: '../../resources/scenes/optionsMenuBackground.png'
        sourceSize: Qt.size(width, height)
    }

    onClosed: backToGame()

    Image {
        anchors.horizontalCenter: parent.horizontalCenter
        asynchronous: true
        height: parent.height * 0.15
        mipmap: true
        source: '../../resources/scenes/button.png'
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
        source: '../../resources/scenes/optionsMenuButton.png'
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
