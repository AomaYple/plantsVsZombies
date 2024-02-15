import QtQuick

Item {
    id: root

    clip: true

    Image {
        id: daytimeGrass

        asynchronous: true
        height: parent.height
        mipmap: true
        source: '../../resources/images/daytimeGrass.png'
        width: height / sourceSize.height * sourceSize.width

        onStatusChanged: if (status === Image.Ready) {
            const aspectRatio = sourceSize.width / sourceSize.height;
            sourceSize = Qt.size(height * aspectRatio, height);
            waitTimer.start();
        }

        XAnimator {
            id: moveAnimator

            duration: 2000
            target: daytimeGrass

            onFinished: if (to === root.width - daytimeGrass.width)
                waitTimer.start()
        }
        Timer {
            id: waitTimer

            interval: 1000

            onTriggered: {
                if (moveAnimator.to === 0)
                    moveAnimator.to = root.width - daytimeGrass.width;
                else
                    moveAnimator.to = -daytimeGrass.width * 0.157;
                moveAnimator.start();
            }
        }
    }
}
