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
        timer.restart();
    }

    function pause() {
        paused = true;
    }

    function propertyChanged() {
        if (running)
            reset();
    }

    function reset() {
        elapsed = interval;
        execute();
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

    onIntervalChanged: propertyChanged()
    onPausedChanged: if (running) {
        if (paused) {
            timer.stop();
            elapsed -= Date.now() - startTime;
        } else
            execute();
    }
    onRepeatChanged: propertyChanged()
    onRunningChanged: {
        if (running && !paused)
            execute();
        else {
            timer.stop();
            elapsed = interval;
        }
    }
    onTriggered: {
        if (repeat)
            reset();
        else
            stop();
    }

    Timer {
        id: timer

        onTriggered: parent.triggered()
    }
}
