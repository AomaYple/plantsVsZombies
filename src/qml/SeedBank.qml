import QtQuick

Item {
    Image {
        id: seedBank

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: '../../resources/images/seedBank.png'
        sourceSize: Qt.size(width, height)

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
}
