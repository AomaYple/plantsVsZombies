import QtQuick

Item {
    id: root

    signal startClicked

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: '../../resources/images/titleScreen.png'
        sourceSize: Qt.size(width, height)

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            asynchronous: true
            height: parent.height * 0.1
            mipmap: true
            source: '../../resources/images/loadBar.png'
            width: height / sourceSize.height * sourceSize.width
            y: parent.height * 0.8

            onStatusChanged: if (status === Image.Ready) {
                const aspectRatio = sourceSize.width / sourceSize.height;
                sourceSize = Qt.size(height * aspectRatio, height);
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: root.startClicked()
            }
        }
    }
}
