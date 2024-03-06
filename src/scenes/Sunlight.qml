import QtQuick
import QtMultimedia

AnimatedImage {
    id: root

    signal collected

    function down() {
        x = getRandomFloat(parent.width * 0.1, parent.width * 0.9);
        y = parent.height * 0.2;
        downAnimation.to = getRandomFloat(parent.height * 0.4, parent.height * 0.9);
        downAnimation.start();
    }
    function getRandomFloat(min, max) {
        return Math.random() * (max - min) + min;
    }

    asynchronous: true
    height: parent.height * 0.14
    mipmap: true
    paused: parent.paused
    source: '../../resources/scenes/sunlight.gif'
    sourceSize: Qt.size(width, height)
    width: height / 56 * 57

    NumberAnimation {
        id: downAnimation

        duration: 3000
        paused: running && root.paused
        properties: 'y'
        target: root
    }
    MouseArea {
        anchors.fill: parent
        cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor

        onClicked: {
            if (downAnimation.to !== 0)
                downAnimation.stop();
            enabled = false;
            pointsSound.play();
            xAnimation.start();
            yAnimation.start();
        }
    }
    SoundEffect {
        id: pointsSound

        source: '../../resources/sounds/points.wav'
    }
    NumberAnimation {
        id: xAnimation

        duration: 500
        paused: running && root.paused
        properties: 'x'
        target: root
        to: parent.width * 0.008

        onFinished: opacityAnimation.start()
    }
    NumberAnimation {
        id: yAnimation

        duration: 500
        paused: running && root.paused
        properties: 'y'
        target: root
        to: -parent.height * 0.01
    }
    NumberAnimation {
        id: opacityAnimation

        duration: 500
        paused: running && root.paused
        properties: 'opacity'
        target: root
        to: 0

        onFinished: {
            root.destroy();
            root.collected();
        }
    }
}
