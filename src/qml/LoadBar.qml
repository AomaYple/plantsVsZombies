import QtQuick

Item {
    id: root

    signal clicked

    Image {
        anchors.fill: parent
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
