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

        OpacityAnimator {
            id: fadeIn

            duration: root.fadeTime
            running: true
            target: popCapLogo
            to: 1

            onFinished: fadeOut.start()
        }
        OpacityAnimator {
            id: fadeOut

            duration: root.fadeTime
            target: popCapLogo
            to: 0

            onFinished: root.finished()
        }
    }
}
