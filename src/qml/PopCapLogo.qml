import QtQuick

Item {
    id: root

    required property real fadeTime

    signal stopped

    Image {
        id: popCapLogo

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        opacity: 0
        source: '../../resources/images/popCapLogo.png'

        OpacityAnimator {
            duration: root.fadeTime
            running: true
            target: popCapLogo
            to: 1

            onStopped: popCapLogoFadeOut.start()
        }
        OpacityAnimator {
            id: popCapLogoFadeOut

            duration: root.fadeTime
            target: popCapLogo
            to: 0

            onStopped: root.stopped()
        }
    }
}
