import QtQuick

Item {
    property int elapsed: interval
    property int interval: 1000
    property bool paused: false
    property bool repeat: false
    property bool running: false
    property int startTime: Date.now()

    signal triggered

    function execute() {
        startTime = Date.now();
        timer.interval = elapsed;
        timer.start();
    }

    function pause() {
        paused = true;
    }

    function reset() {
        if (running) {
            elapsed = interval;
            if (!paused) {
                startTime = Date.now();
                timer.interval = elapsed;
                timer.restart();
            }
        }
    }

    function restart() {
        stop();
        start();
    }

    function resume() {
        paused = false;
    }

    function start() {
        running = true;
    }

    function stop() {
        running = false;
    }

    visible: false

    onIntervalChanged: reset()
    onPausedChanged: if (running) {
        if (paused) {
            timer.stop();
            elapsed -= Date.now() - startTime;
        } else
            execute();
    }
    onRepeatChanged: reset()
    onRunningChanged: {
        if (running) {
            if (!paused)
                execute();
        } else {
            timer.stop();
            elapsed = interval;
        }
    }
    onTriggered: {
        if (repeat) {
            elapsed = interval;
            execute();
        } else
            stop();
    }

    Timer {
        id: timer

        onTriggered: parent.triggered()
    }
}
