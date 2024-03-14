import QtQuick

Item {
    signal entered
    signal quit

    width: height / 23 * 43

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: rootPath + '/resources/scenes/' + (mouseArea.containsMouse ? 'quitHighlight.png' : 'quit.png')
        sourceSize: Qt.size(width, height)
    }
    MouseArea {
        id: mouseArea

        anchors.fill: parent
        cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
        enabled: parent.enabled
        hoverEnabled: enabled

        onClicked: parent.quit()
        onEntered: parent.entered()
    }
}
