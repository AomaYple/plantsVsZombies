import QtQuick

Image {
    signal clicked
    signal entered

    asynchronous: true
    mipmap: true
    source: '../../res/scenes/' + (mouseArea.containsMouse ? 'highlightS' : 's') + 'tartAdventure.png'
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

        onTriggered: parent.source = '../../res/scenes/' + (parent.source.toString() === '../../res/scenes/startAdventure.png' ? 'highlightS' : 's') + 'tartAdventure.png'
    }
}
