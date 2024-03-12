import QtQuick
import QtMultimedia

AnimatedImage {
    id: root

    required property point collectedPosition
    required property real endPositionY
    required property bool natural
    property bool picked: true

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
            yAnimation.duration = 5000;
            yAnimation.to = endPositionY;
            yAnimation.start();
        } else
            scaleAnimation.start();
    }

    SuspendableTimer {
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
            enabled = false;
            scaleAnimation.complete();
            yAnimation.stop();
            soundEffect.play();
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
        to: collectedPosition.x

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
