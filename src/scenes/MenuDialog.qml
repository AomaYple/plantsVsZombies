import QtQuick
import QtQuick.Controls

Dialog {
    id: dialog

    closePolicy: Popup.CloseOnEscape
    modal: true
    width: height / 479 * 402

    background: Image {
        asynchronous: true
        mipmap: true
        source: '../../resources/scenes/optionsMenuBackground.png'
        sourceSize: Qt.size(width, height)
    }

    Image {
        anchors.horizontalCenter: parent.horizontalCenter
        asynchronous: true
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
                pointSize: Math.max(parent.height * 0.25, 1)
            }
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: dialog.accept()
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
        y: parent.height * 0.82

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

            onClicked: dialog.reject()
        }
    }
}
