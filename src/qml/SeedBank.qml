import QtQuick

Item {
    Image {
        anchors.fill: parent
        mipmap: true
        source: '../../resources/scenes/seedBank.png'
        sourceSize: Qt.size(width, height)

        Text {
            color: '#000000'
            text: '0'
            x: parent.width * 0.078
            y: parent.height * 0.74

            font {
                bold: true
                pointSize: height > 0 ? height * 10 : 1
            }
        }
    }
}
