import QtQuick

AnimatedImage {
    id: animatedImage

    function emerge(positionX) {
        visible = true;
        xAnimator.to = positionX;
        xAnimator.start();
    }

    function march(endPositionX) {
        if (paused) {
            paused = false;
            numberAnimation.to = endPositionX;
            numberAnimation.start();
        }
    }

    asynchronous: true
    mipmap: true
    paused: true
    source: '../../resources/scenes/cart.gif'
    sourceSize: Qt.size(width, height)
    visible: false
    width: height / 70 * 85

    XAnimator {
        id: xAnimator

        duration: 500
        target: animatedImage
    }

    NumberAnimation {
        id: numberAnimation

        duration: 5000
        paused: running && target.paused
        properties: 'x'
        target: animatedImage

        onFinished: {
            animatedImage.source = '';
            animatedImage.visible = false;
        }
    }
}
