import QtQuick

Item {
    id: item

    property alias interval: numberAnimation.duration
    property alias paused: numberAnimation.paused
    property bool repeat: false
    property alias running: numberAnimation.running

    signal triggered

    function restart() {
        numberAnimation.restart();
    }

    function start() {
        numberAnimation.start();
    }

    visible: false

    NumberAnimation {
        id: numberAnimation

        paused: running && target.paused
        properties: 'opacity'
        target: item

        onFinished: {
            if (target.repeat)
                start();
            target.triggered();
        }
    }
}
