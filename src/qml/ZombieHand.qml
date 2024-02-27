import QtQuick

Item {
    function rise() {
        rise.start();
    }

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        sourceSize: Qt.size(width, height)

        Timer {
            id: rise

            property int index: 1

            interval: 70
            repeat: true

            onTriggered: if (index < 8)
                parent.source = '../../resources/images/zombieHand' + index++ + '.png'
        }
    }
}
