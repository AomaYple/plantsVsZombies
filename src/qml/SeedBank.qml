import QtQuick

Item {
    id: root

    property alias source: seedBank.source

    Image {
        id: seedBank

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        sourceSize: Qt.size(width, height)

        onStatusChanged: if (status === Image.Ready)
            emerge.start()

        Text {
            color: '#000000'
            text: '0'
            x: parent.width * 0.075
            y: parent.height * 0.7

            font {
                bold: true
                pointSize: height > 0 ? height * 10 : 1
            }
        }
    }
    YAnimator {
        id: emerge

        duration: 500
        target: root
        to: 0
    }
}
