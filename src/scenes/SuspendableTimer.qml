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

    visible: false

    NumberAnimation {
        id: numberAnimation

        properties: 'opacity'
        target: item

        onFinished: {
            if (item.repeat)
                start();
            item.triggered();
        }
    }
}
