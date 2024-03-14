import QtQuick

Item {
    signal loaded

    Image {
        id: image

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        opacity: 0
        source: rootPath + '/resources/scenes/popCapLogo.png'
        sourceSize: Qt.size(width, height)

        onStatusChanged: if (source.toString() === rootPath + '/resources/scenes/popCapLogo.png' && status === Image.Ready)
            opacityAnimator.start()
    }
    OpacityAnimator {
        id: opacityAnimator

        duration: 2000
        target: image
        to: 1

        onFinished: {
            if (to === 1) {
                to = 0;
                restart();
            } else {
                image.opacity = 1;
                image.source = rootPath + '/resources/scenes/titleScreen.png';
            }
        }
    }
    LoadBar {
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height * 0.13
        visible: image.source.toString() === rootPath + '/resources/scenes/titleScreen.png'
        width: height * aspectRatio
        y: parent.height * 0.8

        onClicked: parent.loaded()
    }
}
