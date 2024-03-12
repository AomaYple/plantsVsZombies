import QtQuick

Item {
    id: root

    property alias interval: numberAnimation.duration
    property alias paused: numberAnimation.paused
    property bool repeat: false
    property alias running: numberAnimation.running

    signal triggered

    NumberAnimation {
        id: numberAnimation

        properties: 'opacity'
        target: root

        onFinished: {
            if (root.repeat)
                start();
            root.triggered();
        }
    }
}
