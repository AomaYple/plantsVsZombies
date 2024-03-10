import QtQuick
import QtMultimedia

AnimatedImage {
    id: root

    required property point collectedPosition
    required property real endPositionY
    required property bool natural
    property bool picked: true
    property real upPositionY

    signal collected

    asynchronous: true
    mipmap: true
    scale: 0.5
    source: rootPath + '/resources/scenes/sunlight.gif'
    sourceSize: Qt.size(width, height)
    width: height / 56 * 57

    onStatusChanged: if (status === Image.Ready) {
        if (natural) {
            scale = 1;
            yAnimation.duration = 3000;
            yAnimation.to = endPositionY;
            yAnimation.start();
        } else {
            scaleAnimation.start();
            yAnimation.duration = scaleAnimation.duration;
            yAnimation.to = upPositionY;
        }
    }

    Timer {
        id: timer

        interval: 8000
        running: mouseArea.enabled

        onTriggered: {
            parent.picked = false;
            opacityAnimation.start();
        }
    }
    MouseArea {
        id: mouseArea

        anchors.fill: parent
        cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor

        onClicked: {
            xAnimation.stop();
            yAnimation.stop();
            scaleAnimation.stop();
            enabled = false;
            soundEffect.play();
            xAnimation.to = collectedPosition.x;
            yAnimation.to = collectedPosition.y;
            yAnimation.duration = xAnimation.duration;
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

        paused: running && root.paused
        properties: 'y'
        target: root
    }
    NumberAnimation {
        id: scaleAnimation

        duration: 300
        paused: running && root.paused
        properties: 'scale'
        target: root
        to: 1

        onFinished: {
            yAnimation.to = endPositionY;
            yAnimation.start();
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
