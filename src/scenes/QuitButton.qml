import QtQuick

Image {
    signal entered
    signal quit

    asynchronous: true
    mipmap: true
    source: '../../resources/scenes/' + (mouseArea.containsMouse ? 'quitHighlight.png' : 'quit.png')
    sourceSize: Qt.size(width, height)
    width: height / 23 * 43

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
