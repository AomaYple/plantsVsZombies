import QtQuick

Item {
    id: root

    signal clicked

    anchors.horizontalCenter: parent.horizontalCenter
    height: width / 332 * 94
    width: parent.width * 0.3
    y: parent.height * 0.8

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: '../../resources/scenes/loadBar.png'
        sourceSize: Qt.size(width, height)

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: root.clicked()
        }
    }
}
