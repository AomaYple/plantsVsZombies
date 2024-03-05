import QtQuick
import QtMultimedia

Item {
    id: root

    property bool paused: parent.paused

    signal clicked

    function getRandomFloat(min, max) {
        return Math.random() * (max - min) + min;
    }

    height: width / 57 * 56
    width: parent.width * 0.1
    x: getRandomFloat(parent.width * 0.1, parent.width * 0.9)
    y: parent.height * 0.2

    Component.onCompleted: {
        down.to = getRandomFloat(parent.height * 0.4, parent.height * 0.9);
        down.start();
    }

    AnimatedImage {
        id: background

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        paused: parent.paused
        source: '../../resources/scenes/sunlight.gif'
        sourceSize: Qt.size(width, height)

        MouseArea {
            function collect() {
                collectX.to = root.parent.width * 0.05;
                collectY.to = root.parent.height * 0.05;
                collectX.start();
                collectY.start();
            }

            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                pointsSound.play();
                collect();
                root.clicked();
            }
        }
        SoundEffect {
            id: pointsSound

            source: '../../resources/sounds/points.wav'
        }
        OpacityAnimator {
            id: dissipate

            duration: 500
            paused: running && root.paused
            target: background
            to: 0

            onFinished: root.destroy()
        }
    }
    NumberAnimation {
        id: down

        duration: 3000
        paused: running && root.paused
        properties: 'y'
        target: root
    }
    NumberAnimation {
        id: collectX

        duration: 500
        paused: running && root.paused
        properties: 'x'
        target: root

        onFinished: dissipate.start()
    }
    NumberAnimation {
        id: collectY

        duration: 500
        paused: running && root.paused
        properties: 'y'
        target: root
    }
}
