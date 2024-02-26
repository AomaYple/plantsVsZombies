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
        source: '../../resources/images/popCapLogo.png'
        sourceSize: Qt.size(width, height)

        onStatusChanged: if (background.source.toString() === '../../resources/images/popCapLogo.png' && status === Image.Ready)
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
                    background.source = '../../resources/images/titleScreen.png';
                }
            }
        }
        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            asynchronous: true
            height: parent.height * 0.1
            mipmap: true
            source: parent.source.toString() === '../../resources/images/titleScreen.png' ? '../../resources/images/loadBar.png' : ''
            sourceSize: Qt.size(width, height)
            width: height / 376 * 1328
            y: parent.height * 0.8

            MouseArea {
                anchors.fill: parent
                cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                enabled: parent.status === Image.Ready

                onClicked: root.loaded()
            }
        }
    }
}
