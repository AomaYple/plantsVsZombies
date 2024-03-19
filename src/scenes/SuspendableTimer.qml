import QtQuick

Item {
    id: item

    property alias interval: numberAnimation.duration
    property bool paused: false
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

        paused: running && item.paused
        properties: 'opacity'
        target: item

        onFinished: {
            if (item.repeat)
                start();
            item.triggered();
        }
    }
}
