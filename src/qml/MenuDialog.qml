import QtQuick
import QtQuick.Controls

Item {
    id: root

    property alias active: menuDialogLoader.active

    signal backToGame
    signal backToMainMenu

    Keys.onEscapePressed: backToGame()

    Loader {
        id: menuDialogLoader

        active: false
        anchors.fill: parent
        asynchronous: true

        sourceComponent: Dialog {
            id: menuDialog

            closePolicy: Dialog.NoAutoClose
            modal: true

            background: Image {
                asynchronous: true
                mipmap: true
                source: '../../resources/images/menuBackground.png'
                sourceSize: Qt.size(width, height)
            }

            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                asynchronous: true
                height: parent.height * 0.15
                mipmap: true
                source: '../../resources/images/button.png'
                sourceSize: Qt.size(width, height)
                width: height / 184 * 468
                y: parent.height * 0.63

                Text {
                    anchors.centerIn: parent
                    color: '#008000'
                    text: '主菜单'

                    font {
                        bold: true
                        pointSize: height > 0 ? height * 13 : 1
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
                height: parent.height * 0.21
                mipmap: true
                source: '../../resources/images/backToGame.png'
                sourceSize: Qt.size(width, height)
                width: height / 400 * 1440
                y: parent.height * 0.79

                Text {
                    anchors.centerIn: parent
                    color: '#008000'
                    text: '返回游戏'

                    font {
                        bold: true
                        pointSize: height > 0 ? height * 18 : 1
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
}
