import QtQuick

Item {
    signal clicked
    signal entered

    width: height / 142 * 331

    Image {
        id: image

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: rootPath + '/resources/scenes/' + (mouseArea.containsMouse ? 'startAdventureHighlight.png' : 'startAdventure.png')
        sourceSize: Qt.size(width, height)
    }
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
            if (image.source.toString() === rootPath + '/resources/scenes/startAdventure.png')
                image.source = rootPath + '/resources/scenes/startAdventureHighlight.png';
            else
                image.source = rootPath + '/resources/scenes/startAdventure.png';
        }
    }
}
