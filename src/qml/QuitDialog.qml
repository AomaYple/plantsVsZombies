import QtQuick
import QtQuick.Controls

Item {
    id: root

    property alias active: dialogLoader.active

    signal canceled
    signal quitted

    height: dialogLoader.active && dialogLoader.status === Loader.Ready ? width / dialogLoader.item.aspectRatio : 0

    Loader {
        id: dialogLoader

        active: false
        anchors.fill: parent
        asynchronous: true

        sourceComponent: Dialog {
            property real aspectRatio: dialogBackground.sourceSize.width / dialogBackground.sourceSize.height

            closePolicy: Popup.NoAutoClose
            height: parent.height
            modal: true
            visible: true
            width: parent.width

            background: Image {
                id: dialogBackground

                asynchronous: true
                mipmap: true
                source: '../../resources/images/dialog.png'
            }

            Text {
                color: '#ffff00'
                font.pointSize: height > 0 ? height * 12 : 1
                text: '退出'

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    topMargin: parent.height * 0.25
                }
            }
            Text {
                color: '#ffff00'
                font.pointSize: height > 0 ? height * 10 : 1
                text: '你确定想要退出游戏吗？'

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.top
                    topMargin: parent.height * 0.4
                }
            }
            Button {
                height: width * (quitButtonBackground.sourceSize.height / quitButtonBackground.sourceSize.width)
                width: parent.width * 0.4

                background: Image {
                    id: quitButtonBackground

                    asynchronous: true
                    mipmap: true
                    source: '../../resources/images/button.png'

                    Text {
                        anchors.centerIn: parent
                        color: '#008000'
                        font.pointSize: height > 0 ? height * 9 : 1
                        text: '退出游戏'
                    }
                }

                anchors {
                    bottom: parent.bottom
                    bottomMargin: height * 0.13
                    left: parent.left
                    leftMargin: width * 0.15
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked: root.quitted()
                }
            }
            Button {
                height: width * (cancelButtonBackground.sourceSize.height / cancelButtonBackground.sourceSize.width)
                width: parent.width * 0.4

                background: Image {
                    id: cancelButtonBackground

                    asynchronous: true
                    mipmap: true
                    source: '../../resources/images/button.png'

                    Text {
                        anchors.centerIn: parent
                        color: '#008000'
                        font.pointSize: height > 0 ? height * 9 : 1
                        text: '取消'
                    }
                }

                anchors {
                    bottom: parent.bottom
                    bottomMargin: height * 0.13
                    right: parent.right
                    rightMargin: width * 0.15
                }
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked: root.canceled()
                }
            }
        }
    }
}
