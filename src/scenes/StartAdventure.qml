import QtQuick

Image {
    signal clicked
    signal entered

    asynchronous: true
    height: parent.height * 0.23
    mipmap: true
    source: mouseArea.containsMouse ? '../../resources/scenes/startAdventureHighlight.png' : '../../resources/scenes/startAdventure.png'
    sourceSize: Qt.size(width, height)
    width: height / 142 * 331
    x: parent.width * 0.52
    y: parent.height * 0.1

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
        enabled: parent.enabled
        hoverEnabled: enabled

        onClicked: {
            timer.start();
            parent.clicked();
        }
        onEntered: parent.entered()
    }
    Timer {
        id: timer

        interval: 100
        repeat: true

        onTriggered: {
            if (parent.source.toString() === '../../resources/scenes/startAdventure.png')
                parent.source = '../../resources/scenes/startAdventureHighlight.png';
            else
                parent.source = '../../resources/scenes/startAdventure.png';
        }
    }
}
