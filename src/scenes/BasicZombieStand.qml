import QtQuick

Item {
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
    }
}
