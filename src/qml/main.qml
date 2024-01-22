import QtQuick
import QtMultimedia

Window {
    color: '#000000'
    height: 1080
    title: '植物大战僵尸'
    visible: true
    width: 1920

    Component.onCompleted: backgroundMusic.play()

    Loader {
        id: background

        anchors.fill: parent
        asynchronous: true
        sourceComponent: popCapLogoComponent
    }
    Component {
        id: popCapLogoComponent

        Image {
            id: popCapLogo

            anchors.centerIn: parent
            asynchronous: true
            mipmap: true
            opacity: 0
            source: '../../resources/images/popCapLogo.png'

            OpacityAnimator {
                duration: 2000
                running: true
                target: popCapLogo
                to: 1

                onStopped: popCapLogoFadeOut.start()
            }
            OpacityAnimator {
                id: popCapLogoFadeOut

                duration: 2000
                target: popCapLogo
                to: 0

                onStopped: background.sourceComponent = titleScreenComponent
            }
        }
    }
    Component {
        id: titleScreenComponent

        Image {
            id: titleScreen

            property real loadTime: 5000

            anchors.fill: parent
            asynchronous: true
            mipmap: true
            source: '../../resources/images/titleScreen.png'

            Image {
                id: loadBarDirt

                asynchronous: true
                height: width * (sourceSize.height / sourceSize.width)
                mipmap: true
                source: '../../resources/images/loadBarDirt.png'
                width: parent.width * 0.35

                anchors {
                    bottom: parent.bottom
                    bottomMargin: parent.height * 0.1
                    horizontalCenter: parent.horizontalCenter
                }
            }
            Rectangle {
                clip: true
                color: 'transparent'
                height: loadBarGrass.height
                width: 0

                Behavior on width {
                    NumberAnimation {
                        duration: titleScreen.loadTime
                    }
                }

                Component.onCompleted: width = loadBarDirt.width

                anchors {
                    bottom: loadBarDirt.bottom
                    bottomMargin: loadBarDirt.height * 0.7
                    left: loadBarDirt.left
                }
                Image {
                    id: loadBarGrass

                    asynchronous: true
                    height: width * (sourceSize.height / sourceSize.width)
                    mipmap: true
                    source: '../../resources/images/loadBarGrass.png'
                    width: loadBarDirt.width * 0.98
                }
            }
            Image {
                id: sodRollCap

                asynchronous: true
                height: width * (sourceSize.height / sourceSize.width)
                mipmap: true
                source: '../../resources/images/sodRollCap.png'
                width: parent.width * 0.05
                x: (parent.width - loadBarDirt.width - width) / 2
                y: loadBarDirt.y - height / 2

                RotationAnimator on rotation {
                    duration: titleScreen.loadTime
                    to: 360
                }
                ScaleAnimator on scale {
                    duration: titleScreen.loadTime
                    to: 0.3

                    onStopped: sodRollCap.source = ''
                }
                XAnimator on x {
                    duration: titleScreen.loadTime
                    to: parent.width - loadBarDirt.width
                }
            }
        }
    }
    MediaPlayer {
        id: backgroundMusic

        loops: MediaPlayer.Infinite
        source: '../../resources/music/CrazyDave.flac'

        audioOutput: AudioOutput {
        }
    }
}
