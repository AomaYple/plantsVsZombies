import QtQuick

Item {
    readonly property real aspectRatio: image.sourceSize.width / image.sourceSize.height

    signal clicked

    Image {
        id: image

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: rootPath + '/resources/scenes/loadBar.png'

        onStatusChanged: if (status === Image.Ready) {
            const aspectRatio = sourceSize.width / sourceSize.height;
            sourceSize = Qt.binding(function () {
                return Qt.size(height * aspectRatio, parent.height);
            });
        }
    }
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: parent.clicked()
    }
}
