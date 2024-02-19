import QtQuick
import QtMultimedia

Item {
    id: root

    signal chooseStarted
    signal chose
    signal started

    clip: true

    Image {
        id: daytimeGrass

        readonly property real leftPadding: width * 0.157

        asynchronous: true
        height: parent.height
        mipmap: true
        source: '../../resources/images/daytimeGrass.png'
        sourceSize: Qt.size(width, height)
        width: height / 2400 * 5600

        onStatusChanged: if (status === Image.Ready) {
            parent.chooseStarted();
            waitTimer.start();
        }

        XAnimator {
            id: moveAnimator

            duration: 2000
            target: daytimeGrass

            onFinished: {
                if (to === root.width - daytimeGrass.width)
                    waitTimer.start();
                else {
                    root.chose();
                    basicZombieStand1.source = '';
                    basicZombieStand2.source = '';
                    basicZombieStand3.source = '';
                    basicZombieStand4.source = '';
                    startImage.source = '../../resources/images/startReady.png';
                    startTimer.start();
                }
            }
        }
        Timer {
            id: waitTimer

            interval: 2000

            onTriggered: {
                if (moveAnimator.to === 0)
                    moveAnimator.to = root.width - parent.width;
                else {
                    moveAnimator.duration = 1500;
                    moveAnimator.to = -parent.leftPadding;
                }
                moveAnimator.start();
            }
        }
        AnimatedImage {
            id: basicZombieStand1

            asynchronous: true
            height: parent.height * 0.32
            mipmap: true
            source: '../../resources/gif/basicZombieStand1.gif'
            sourceSize: Qt.size(width, height)
            width: height
            x: parent.width * 0.8
            y: parent.height * 0.5
        }
        AnimatedImage {
            id: basicZombieStand2

            asynchronous: true
            height: parent.height * 0.32
            mipmap: true
            source: '../../resources/gif/basicZombieStand2.gif'
            sourceSize: Qt.size(width, height)
            width: height
            x: parent.width * 0.85
            y: parent.height * 0.3
        }
        AnimatedImage {
            id: basicZombieStand3

            asynchronous: true
            height: parent.height * 0.32
            mipmap: true
            source: '../../resources/gif/basicZombieStand2.gif'
            sourceSize: Qt.size(width, height)
            width: height
            x: parent.width * 0.83
            y: parent.height * 0.4
        }
        AnimatedImage {
            id: basicZombieStand4

            asynchronous: true
            height: parent.height * 0.32
            mipmap: true
            source: '../../resources/gif/basicZombieStand1.gif'
            sourceSize: Qt.size(width, height)
            width: height
            x: parent.width * 0.75
            y: parent.height * 0.2
        }
        Image {
            id: startImage

            anchors.centerIn: parent
            asynchronous: true
            height: parent.height * 0.3
            mipmap: true
            sourceSize: Qt.size(width, height)
            width: height / 532 * 1200

            Timer {
                id: startTimer

                interval: 700

                onTriggered: {
                    if (parent.source.toString() === '../../resources/images/startReady.png') {
                        parent.source = '../../resources/images/startSet.png';
                        start();
                    } else if (parent.source.toString() === '../../resources/images/startSet.png') {
                        parent.source = '../../resources/images/startPlant.png';
                        start();
                    } else if (parent.source.toString() === '../../resources/images/startPlant.png') {
                        parent.source = '';
                        root.started();
                    }
                }
            }
        }
    }
}
