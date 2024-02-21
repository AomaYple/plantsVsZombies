import QtQuick

Item {
    id: root

    signal started

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
            sourceSize: Qt.size(width, height)
            width: height / 376 * 1328
            y: parent.height * 0.8

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: root.started()
            }
        }
    }
}
