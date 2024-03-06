import QtQuick

Image {
    signal entered
    signal quit

    asynchronous: true
    height: parent.height * 0.04
    mipmap: true
    source: mouseArea.containsMouse ? '../../resources/scenes/quitHighlight.png' : '../../resources/scenes/quit.png'
    sourceSize: Qt.size(width, height)
    width: height / 23 * 43
    x: parent.width * 0.903
    y: parent.height * 0.86

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
