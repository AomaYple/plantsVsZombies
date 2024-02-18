import QtQuick

Item {
    id: root

    signal chooseStarted
    signal chose

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
                else
                    root.chose();
            }
        }
        Timer {
            id: waitTimer

            interval: 1000

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
    }
}
