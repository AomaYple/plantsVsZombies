import QtQuick

AnimatedImage {
    id: animatedImage

    required property point collectedPosition
    required property real endPositionY
    required property bool natural
    property bool picked: true

    signal clicked
    signal collected

    asynchronous: true
    mipmap: true
    source: '../../resources/scenes/sunlight.gif'
    sourceSize: Qt.size(width, height)
    width: height / 56 * 57

    onStatusChanged: if (status === Image.Ready) {
        if (natural) {
            yAnimation.duration = 5000;
            yAnimation.to = endPositionY;
            yAnimation.running = true;
        } else {
            scale = 0.5;
            scaleAnimation.running = true;
        }
    }

    SuspendableTimer {
        interval: 8000
        running: mouseArea.enabled

        onTriggered: {
            parent.picked = false;
            opacityAnimation.running = true;
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor

        onClicked: {
            enabled = false;
            scaleAnimation.complete();
            yAnimation.running = false;
            yAnimation.to = collectedPosition.y;
            yAnimation.duration = xAnimation.duration;
            xAnimation.running = true;
            yAnimation.running = true;
            parent.clicked();
        }
    }

    NumberAnimation {
        id: xAnimation

        duration: 500
        paused: running && animatedImage.paused
        properties: 'x'
        target: animatedImage
        to: animatedImage.collectedPosition.x

        onFinished: opacityAnimation.running = true
    }

    NumberAnimation {
        id: yAnimation

        paused: running && animatedImage.paused
        properties: 'y'
        target: animatedImage
    }

    NumberAnimation {
        id: scaleAnimation

        duration: 300
        paused: running && animatedImage.paused
        properties: 'scale'
        target: animatedImage
        to: 1

        onFinished: {
            yAnimation.to = endPositionY;
            yAnimation.running = true;
        }
    }

    NumberAnimation {
        id: opacityAnimation

        duration: 500
        paused: running && animatedImage.paused
        properties: 'opacity'
        target: animatedImage
        to: 0

        onFinished: {
            animatedImage.destroy();
            if (animatedImage.picked)
                animatedImage.collected();
        }
    }
}
