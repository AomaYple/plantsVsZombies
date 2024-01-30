import QtQuick
import QtQuick.Controls

Item {
    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: '../../resources/images/mainMenu.png'

        Image {
            asynchronous: true
            height: parent.height * 0.05
            mipmap: true
            source: quitButton.hovered ? '../../resources/images/quitHovered.png' : '../../resources/images/quit.png'
            width: parent.width * 0.04

            anchors {
                bottom: parent.bottom
                bottomMargin: parent.height * 0.1
                right: parent.right
                rightMargin: parent.width * 0.05
            }
            Button {
                id: quitButton

                anchors.fill: parent

                background: Rectangle {
                    color: 'transparent'
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
        Image {
            asynchronous: true
            height: parent.height * 0.04
            mipmap: true
            source: startButton.hovered ? '../../resources/images/helpHovered.png' : '../../resources/images/help.png'
            width: parent.width * 0.04

            anchors {
                bottom: parent.bottom
                bottomMargin: parent.height * 0.09
                right: parent.right
                rightMargin: parent.width * 0.14
            }
            Button {
                id: startButton

                anchors.fill: parent

                background: Rectangle {
                    color: 'transparent'
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
        Image {
            asynchronous: true
            height: parent.height * 0.05
            mipmap: true
            source: helpButton.hovered ? '../../resources/images/optionsHovered.png' : '../../resources/images/options.png'
            width: parent.width * 0.06

            anchors {
                bottom: parent.bottom
                bottomMargin: parent.height * 0.13
                right: parent.right
                rightMargin: parent.width * 0.215
            }
            Button {
                id: helpButton

                anchors.fill: parent

                background: Rectangle {
                    color: 'transparent'
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }
}
