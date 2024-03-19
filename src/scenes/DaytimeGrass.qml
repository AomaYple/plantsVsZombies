import QtQuick
import "../js/common.js" as Common

Item {
    id: item

    signal finished

    function judder() {
        judderAnimator.start();
    }

    Image {
        id: image

        readonly property real leftMargin: width * 0.157
        readonly property Component standingBasicZombieComponent: Qt.createComponent('../zombies/StandingBasicZombie.qml')
        readonly property Component standingBucketHeadZombie: Qt.createComponent('../zombies/StandingBucketHeadZombie.qml')
        readonly property Component standingConeHeadZombie: Qt.createComponent('../zombies/StandingConeHeadZombie.qml')

        asynchronous: true
        height: parent.height
        mipmap: true
        source: '../../resources/scenes/daytimeGrass.png'
        sourceSize: Qt.size(width, height)
        width: height / 600 * 1400

        onStatusChanged: if (status === Image.Ready) {
            Common.produceStandingZombies();
            timer.start();
        }
    }

    Timer {
        id: timer

        interval: 1500

        onTriggered: moveAnimator.start()
    }

    XAnimator {
        id: moveAnimator

        duration: 2000
        target: image
        to: item.width - image.width

        onFinished: {
            if (to === item.width - image.width) {
                to = -image.leftMargin;
                timer.start();
            } else
                item.finished();
        }
    }

    XAnimator {
        id: judderAnimator

        readonly property real gap: -image.height * 0.01

        duration: 200
        target: image
        to: gap - image.leftMargin

        onFinished: if (to === gap - image.leftMargin) {
            to = -image.leftMargin;
            start();
        } else
            to = gap - image.leftMargin
    }

    YAnimator {
        duration: judderAnimator.duration
        running: judderAnimator.running
        target: image
        to: judderAnimator.gap

        onFinished: if (to === judderAnimator.gap)
            to = 0
        else
            to = judderAnimator.gap
    }
}
