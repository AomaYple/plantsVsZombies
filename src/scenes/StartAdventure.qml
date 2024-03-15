import QtQuick

Image {
    signal clicked
    signal entered

    asynchronous: true
    mipmap: true
    source: '../../resources/scenes/' + (mouseArea.containsMouse ? 'startAdventureHighlight.png' : 'startAdventure.png')
    sourceSize: Qt.size(width, height)
    width: height / 142 * 331

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
