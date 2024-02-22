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
        property bool shoveling: false

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

        MouseArea {
            id: overall

            enabled: false
            height: root.height
            hoverEnabled: true
            width: root.width
            x: parent.leftMargin

            onPositionChanged: {
                if (shovelBank.shoveling) {
                    shovel.x = mouseX - shovel.width / 2 + parent.leftMargin;
                    shovel.y = mouseY - shovel.height / 2;
                }
            }
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
                    basicZombie1.source = '';
                    readySetPlant.source = '../../resources/images/startReady.png';
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
        Zombie {
            id: basicZombie1

            height: parent.height * 0.2
            source: '../../resources/gif/basicZombieStand1.gif'
            width: height / 125 * 82
            x: parent.width * 0.8
            y: parent.height * 0.5
        }
        Zombie {
            id: basicZombie2

            height: parent.height * 0.2
            source: basicZombie1.source.toString() === '' ? '' : '../../resources/gif/basicZombieStand1.gif'
            width: height / 121 * 82
            x: parent.width * 0.85
            y: parent.height * 0.3
        }
        Zombie {
            id: basicZombie3

            height: parent.height * 0.2
            source: basicZombie2.source.toString() === '' ? '' : '../../resources/gif/basicZombieStand2.gif'
            width: height / 121 * 82
            x: parent.width * 0.83
            y: parent.height * 0.4
        }
        Zombie {
            id: basicZombie4

            height: parent.height * 0.2
            source: basicZombie3.source.toString() === '' ? '' : '../../resources/gif/basicZombieStand2.gif'
            width: height / 125 * 82
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
            width: height / 408 * 864
            x: (parent.width - parent.leftMargin - width) / 2

            onStatusChanged: if (status === Image.Ready) {
                readySetPlantTimer.start();
                if (source.toString() !== '../../resources/images/startPlant.png')
                    readySetPlantEnlarge.start();
            }

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
                        overall.enabled = true;
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
        SeedBank {
            id: seedBank

            height: parent.height * 0.15
            width: height / 348 * 1784
            x: parent.width * 0.01 + parent.leftMargin
            y: -height
        }
        ShovelBank {
            id: shovelBank

            anchors.left: seedBank.right
            enabled: overall.enabled
            height: seedBank.height * 0.8
            source: seedBank.source.toString() === '' ? '' : '../../resources/images/shovelBank.png'
            width: height / 288 * 280
            y: -height

            onClicked: {
                if (shoveling) {
                    shoveling = false;
                    shovel.x = x + (width - shovel.width) / 2;
                    shovel.y = y + (height - shovel.height) / 2;
                } else
                    shoveling = true;
            }
        }
        Image {
            id: shovel

            asynchronous: true
            height: shovelBank.height * 0.8
            mipmap: true
            source: shovelBank.source.toString() === '' ? '' : '../../resources/images/shovel.png'
            sourceSize: Qt.size(width, height)
            width: height / 256 * 244
            x: shovelBank.x + (shovelBank.width - width) / 2
            y: shovelBank.y + (shovelBank.height - height) / 2

            onStatusChanged: if (status === Image.Ready)
                shovelEmerge.start()

            YAnimator {
                id: shovelEmerge

                duration: 500
                target: shovel
                to: (shovelBank.height - shovel.height) / 2
            }
        }
    }
}
