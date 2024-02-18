import QtQuick

Item {
    id: root

    required property real fadeTime

    signal finished

    Image {
        id: popCapLogo

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        opacity: 0
        source: '../../resources/images/popCapLogo.png'
        sourceSize: Qt.size(width, height)

        onStatusChanged: if (status === Image.Ready)
            fade.start()

        OpacityAnimator {
            id: fade

            duration: root.fadeTime
            target: popCapLogo
            to: 1

            onFinished: {
                if (to === 1) {
                    to = 0;
                    restart();
                } else
                    root.finished();
            }
        }
    }
}
