import QtQuick

Item {
    id: root

    signal finished

    function start() {
        background.source = '../../resources/images/startReady.png';
    }

    Image {
        id: background

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        sourceSize: Qt.size(width, height)

        onStatusChanged: if (status === Image.Ready) {
            if (source.toString() !== '../../resources/images/startPlant.png')
                enlarge.start();
            interval.start();
        }

        Timer {
            id: interval

            interval: 700

            onTriggered: {
                if (parent.source.toString() === '../../resources/images/startReady.png') {
                    enlarge.stop();
                    parent.source = '../../resources/images/startSet.png';
                    start();
                } else if (parent.source.toString() === '../../resources/images/startSet.png') {
                    enlarge.stop();
                    parent.source = '../../resources/images/startPlant.png';
                    start();
                } else {
                    parent.source = '';
                    root.finished();
                }
            }
        }
        ScaleAnimator {
            id: enlarge

            duration: 300
            target: background
            to: 1.3

            onStopped: background.scale = 1
        }
    }
}
