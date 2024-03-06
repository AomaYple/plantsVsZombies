import QtQuick

Image {
    signal clicked

    anchors.horizontalCenter: parent.horizontalCenter
    asynchronous: true
    height: parent.height * 0.13
    mipmap: true
    source: '../../resources/scenes/loadBar.png'
    sourceSize: Qt.size(width, height)
    visible: parent.source.toString() === '../../resources/scenes/titleScreen.png'
    width: height / 94 * 332
    y: parent.height * 0.8

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: parent.clicked()
    }
}
