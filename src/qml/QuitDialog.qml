import QtQuick
import QtQuick.Controls

Item {
    id: root

    property real aspectRatio: dialogBackground.sourceSize.width / dialogBackground.sourceSize.height

    signal canceled
    signal quitted

    Dialog {
        id: dialog

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
        Image {
            asynchronous: true
            height: width * (sourceSize.height / sourceSize.width)
            mipmap: true
            source: '../../resources/images/button.png'
            width: parent.width * 0.4

            anchors {
                bottom: parent.bottom
                bottomMargin: height * 0.13
                left: parent.left
                leftMargin: width * 0.15
            }
            Text {
                anchors.centerIn: parent
                color: '#008000'
                font.pointSize: height > 0 ? height * 9 : 1
                text: '退出游戏'
            }
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: root.quitted()
            }
        }
        Image {
            asynchronous: true
            height: width * (sourceSize.height / sourceSize.width)
            mipmap: true
            source: '../../resources/images/button.png'
            width: parent.width * 0.4

            anchors {
                bottom: parent.bottom
                bottomMargin: height * 0.13
                right: parent.right
                rightMargin: width * 0.15
            }
            Text {
                anchors.centerIn: parent
                color: '#008000'
                font.pointSize: height > 0 ? height * 9 : 1
                text: '取消'
            }
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: root.canceled()
            }
        }
    }
}
