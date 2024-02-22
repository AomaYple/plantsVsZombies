import QtQuick

Item {
    property alias source: image.source

    AnimatedImage {
        id: image

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        sourceSize: Qt.size(width, height)

        Image {
            asynchronous: true
            height: parent.height * 0.25
            mipmap: true
            source: '../../resources/images/shadow.png'
            sourceSize: Qt.size(width, height)
            width: height / 188 * 284
            x: parent.width * 0.4
            y: parent.height * 0.8
        }
    }
}
