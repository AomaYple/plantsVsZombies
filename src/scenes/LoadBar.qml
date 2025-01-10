import QtQuick

Image {
    signal clicked

    asynchronous: true
    mipmap: true
    source: '../../res/scenes/loadBar.png'
    sourceSize: Qt.size(width, height)
    width: height / 94 * 332

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: parent.clicked()
    }
}
