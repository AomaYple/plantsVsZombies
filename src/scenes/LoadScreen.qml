import QtQuick

Item {
    id: root

    signal loaded

    Image {
        id: background

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        opacity: 0
        source: '../../resources/scenes/popCapLogo.png'
        sourceSize: Qt.size(width, height)

        onStatusChanged: if (background.source.toString() === '../../resources/scenes/popCapLogo.png' && status === Image.Ready)
            fade.start()

        OpacityAnimator {
            id: fade

            duration: 2000
            target: background
            to: 1

            onFinished: {
                if (to === 1) {
                    to = 0;
                    restart();
                } else {
                    background.opacity = 1;
                    background.source = '../../resources/scenes/titleScreen.png';
                }
            }
        }
        LoadBar {
            anchors.horizontalCenter: parent.horizontalCenter
            visible: background.source.toString() === '../../resources/scenes/titleScreen.png'
            width: parent.width * 0.3
            y: parent.height * 0.8

            onClicked: root.loaded()
        }
    }
}
