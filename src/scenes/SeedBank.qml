import QtQuick

Item {
    height: width / 446 * 87

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: '../../resources/scenes/seedBank.png'
        sourceSize: Qt.size(width, height)

        Text {
            color: '#000000'
            text: '0'
            x: parent.width * 0.078
            y: parent.height * 0.72

            font {
                bold: true
                pointSize: height > 0 ? height * 5 : 1
            }
        }
    }
}
