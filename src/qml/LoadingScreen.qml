import QtQuick

Item {
    signal loaded

    Image {
        id: background

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        opacity: 0
        source: '../../resources/images/popCapLogo.png'
        sourceSize: Qt.size(width, height)

        onStatusChanged: if (background.toString() === '../../resources/images/popCapLogo.png' && status === Image.Ready)
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
                    background.source = '../../resources/images/titleScreen.png';
                    loadBar.source = '../../resources/images/loadBar.png';
                }
            }
        }
        Image {
            id: loadBar
            anchors.horizontalCenter: parent.horizontalCenter
            asynchronous: true
            mipmap: true
            sourceSize: Qt.size(width, height)
            height: parent.height * 0.1
            width: height / 376 * 1328
            y: parent.height * 0.8

            MouseArea {
                anchors.fill: parent
                cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                enabled: parent.source.toString() !== ''

                onClicked: root.loaded()
            }
        }
    }
}
