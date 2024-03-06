import QtQuick

Image {
    id: root

    signal loaded

    asynchronous: true
    mipmap: true
    opacity: 0
    source: '../../resources/scenes/popCapLogo.png'
    sourceSize: Qt.size(width, height)

    onStatusChanged: if (source.toString() === '../../resources/scenes/popCapLogo.png' && status === Image.Ready)
        opacityAnimator.start()

    OpacityAnimator {
        id: opacityAnimator

        duration: 2000
        target: root
        to: 1

        onFinished: {
            if (to === 1) {
                to = 0;
                restart();
            } else {
                root.opacity = 1;
                root.source = '../../resources/scenes/titleScreen.png';
            }
        }
    }
    LoadBar {
        onClicked: parent.loaded()
    }
}
