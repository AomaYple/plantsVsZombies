import QtQuick
import QtQuick.Controls
import QtMultimedia

Item {
    id: root

    signal quitted

    Loader {
        id: loader

        anchors.fill: parent
        asynchronous: true
        sourceComponent: mainMenuComponent

        Component {
            id: mainMenuComponent

            Image {
                anchors.fill: parent
                asynchronous: true
                mipmap: true
                source: '../../resources/images/mainMenu.png'

                Image {
                    asynchronous: true
                    height: width * (sourceSize.height / sourceSize.width)
                    mipmap: true
                    source: quitButton.hovered ? '../../resources/images/quitHovered.png' : '../../resources/images/quit.png'
                    width: parent.width * 0.045
                    x: parent.width * 0.91
                    y: parent.height * 0.85

                    Button {
                        id: quitButton

                        anchors.fill: parent

                        background: Rectangle {
                            color: 'transparent'
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor

                            onClicked: quitDialog.active = true
                        }
                    }
                }
                QuitDialog {
                    id: quitDialog

                    anchors.centerIn: parent
                    width: parent.width * 0.3

                    onCanceled: active = false
                    onQuitted: root.quitted()
                }
                Image {
                    asynchronous: true
                    height: width * (sourceSize.height / sourceSize.width)
                    mipmap: true
                    source: helpButton.hovered ? '../../resources/images/helpHovered.png' : '../../resources/images/help.png'
                    width: parent.width * 0.05
                    x: parent.width * 0.815
                    y: parent.height * 0.86

                    Button {
                        id: helpButton

                        anchors.fill: parent

                        background: Rectangle {
                            color: 'transparent'
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor

                            onClicked: loader.sourceComponent = helpPaperComponent
                        }
                    }
                }
                Image {
                    asynchronous: true
                    height: width * (sourceSize.height / sourceSize.width)
                    mipmap: true
                    source: optionsButton.hovered ? '../../resources/images/optionsHovered.png' : '../../resources/images/options.png'
                    width: parent.width * 0.07
                    x: parent.width * 0.72
                    y: parent.height * 0.81

                    Button {
                        id: optionsButton

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
        Component {
            id: helpPaperComponent

            HelpPaper {
                onClickedMainMenuButton: loader.sourceComponent = mainMenuComponent
            }
        }
    }
}
