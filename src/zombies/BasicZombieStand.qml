import QtQuick

Item {
    height: width / 84 * 126

    AnimatedImage {
        function randomIndex() {
            const min = 0, max = 1;
            return Math.floor(Math.random() * (max - min + 1)) + min;
        }

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: '../../resources/zombies/basicZombieStand' + randomIndex() + '.gif'
        sourceSize: Qt.size(width, height)

        Image {
            anchors.bottom: parent.bottom
            asynchronous: true
            height: parent.height * 0.2
            mipmap: true
            source: '../../resources/scenes/shadow.png'
            sourceSize: Qt.size(width, height)
            width: height / 49 * 73
        }
    }
}
