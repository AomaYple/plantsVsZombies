import QtQuick
import QtMultimedia

Item {
    id: root

    signal choose
    signal chose
    signal started

    clip: true

    Image {
        id: daytimeGrass

        readonly property real leftMargin: width * 0.157

        asynchronous: true
        height: parent.height
        mipmap: true
        source: '../../resources/images/daytimeGrass.png'
        sourceSize: Qt.size(width, height)
        width: height / 2400 * 5600

        onStatusChanged: if (status === Image.Ready) {
            parent.choose();
            rollOverTimer.start();
        }

        XAnimator {
            id: rollOverAnimator

            duration: 2000
            target: daytimeGrass

            onFinished: {
                if (to === root.width - daytimeGrass.width)
                    rollOverTimer.start();
                else {
                    root.chose();
                    basicZombieStand1.source = '';
                    basicZombieStand2.source = '';
                    basicZombieStand3.source = '';
                    basicZombieStand4.source = '';
                    readySetPlant.source = '../../resources/images/startReady.png';
                    readySetPlantTimer.start();
                    seedBank.source = '../../resources/images/seedBank.png';
                }
            }
        }
        Timer {
            id: rollOverTimer

            interval: 1500

            onTriggered: {
                if (rollOverAnimator.to === 0)
                    rollOverAnimator.to = root.width - parent.width;
                else
                    rollOverAnimator.to = -parent.leftMargin;
                rollOverAnimator.start();
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
            source: '../../resources/gif/basicZombieStand1.gif'
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
            source: '../../resources/gif/basicZombieStand2.gif'
            sourceSize: Qt.size(width, height)
            width: height
            x: parent.width * 0.75
            y: parent.height * 0.2
        }
        Image {
            id: readySetPlant

            anchors.verticalCenter: parent.verticalCenter
            asynchronous: true
            height: parent.height * 0.3
            mipmap: true
            sourceSize: Qt.size(width, height)
            width: height / 532 * 1200
            x: (parent.width - parent.leftMargin - width) / 2

            onStatusChanged: if (status === Image.Ready && source.toString() !== '../../resources/images/startPlant.png')
                readySetPlantEnlarge.start()

            Timer {
                id: readySetPlantTimer

                interval: 700

                onTriggered: {
                    if (parent.source.toString() === '../../resources/images/startReady.png') {
                        parent.height = daytimeGrass.height * 0.2;
                        parent.source = '../../resources/images/startSet.png';
                        start();
                    } else if (parent.source.toString() === '../../resources/images/startSet.png') {
                        parent.height = daytimeGrass.height * 0.4;
                        parent.source = '../../resources/images/startPlant.png';
                        start();
                    } else if (parent.source.toString() === '../../resources/images/startPlant.png') {
                        parent.source = '';
                        root.started();
                    }
                }
            }
            ScaleAnimator {
                id: readySetPlantEnlarge

                duration: 300
                target: readySetPlant
                to: 1.3

                onFinished: readySetPlant.scale = 1
            }
        }
        Image {
            id: seedBank

            asynchronous: true
            height: parent.height * 0.15
            mipmap: true
            sourceSize: Qt.size(width, height)
            width: height / 348 * 1784
            x: parent.width * 0.01 + parent.leftMargin
            y: -height

            onStatusChanged: if (status === Image.Ready)
                seedBankEmerge.start()

            YAnimator {
                id: seedBankEmerge

                duration: 500
                target: seedBank
                to: 0
            }
            Text {
                id: sunlightCount

                color: '#000000'
                text: '0'
                x: parent.width * 0.075
                y: parent.height * 0.7

                font {
                    bold: true
                    pointSize: height > 0 ? height * 10 : 1
                }
            }
        }
    }
}
