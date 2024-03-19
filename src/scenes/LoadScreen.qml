import QtQuick

Image {
    id: image

    signal loaded

    asynchronous: true
    mipmap: true
    opacity: 0
    source: '../resources/scenes/popCapLogo.png'
    sourceSize: Qt.size(width, height)

    onStatusChanged: if (source.toString() === '../resources/scenes/popCapLogo.png' && status === Image.Ready)
        opacityAnimator.start()

    OpacityAnimator {
        id: opacityAnimator

        duration: 2000
        target: image
        to: 1

        onFinished: {
            if (to === 1) {
                to = 0;
                start();
            } else {
                image.opacity = 1;
                image.source = '../resources/scenes/titleScreen.png';
            }
        }
    }

    LoadBar {
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height * 0.13
        visible: parent.source.toString() === '../resources/scenes/titleScreen.png'
        y: parent.height * 0.8

        onClicked: parent.loaded()
    }
}
