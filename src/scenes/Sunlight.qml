import QtQuick
import QtMultimedia

AnimatedImage {
    id: root

    property bool picked: true

    signal collected

    function naturalGenerate(beginPosition: point, endPositionY: real, collectedPosition: point) {
        x = beginPosition.x;
        y = beginPosition.y;
        fallAnimation.to = endPositionY;
        fallAnimation.start();
        xAnimation.to = collectedPosition.x;
        yAnimation.to = collectedPosition.y;
    }

    asynchronous: true
    mipmap: true
    source: rootPath + '/resources/scenes/sunlight.gif'
    sourceSize: Qt.size(width, height)
    width: height / 56 * 57

    NumberAnimation {
        id: fallAnimation

        duration: 3000
        paused: running && root.paused
        properties: 'y'
        target: root
    }
    MouseArea {
        id: mouseArea

        anchors.fill: parent
        cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor

        onClicked: {
            fallAnimation.stop();
            enabled = false;
            soundEffect.play();
            xAnimation.start();
            yAnimation.start();
        }
    }
    SoundEffect {
        id: soundEffect

        source: rootPath + '/resources/sounds/points.wav'
    }
    NumberAnimation {
        id: xAnimation

        duration: 500
        paused: running && root.paused
        properties: 'x'
        target: root

        onFinished: opacityAnimation.start()
    }
    NumberAnimation {
        id: yAnimation

        duration: 500
        paused: running && root.paused
        properties: 'y'
        target: root
    }
    Timer {
        id: timer

        interval: 8000
        running: mouseArea.enabled

        onTriggered: {
            root.picked = false;
            opacityAnimation.start();
        }
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
            if (root.picked)
                root.collected();
        }
    }
}
