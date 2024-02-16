import QtQuick

Item {
    id: root

    required property real fadeTime

    signal finished

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        opacity: 0
        source: '../../resources/images/popCapLogo.png'
        sourceSize: Qt.size(width, height)

        OpacityAnimator on opacity {
            duration: root.fadeTime
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
