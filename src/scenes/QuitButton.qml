import QtQuick

Item {
    id: root

    signal entered
    signal quit

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: mouseArea.containsMouse ? '../../resources/scenes/quitHighlight.png' : '../../resources/scenes/quit.png'
        sourceSize: Qt.size(width, height)

        MouseArea {
            id: mouseArea

            anchors.fill: parent
            cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
            enabled: root.enabled
            hoverEnabled: enabled

            onClicked: root.quit()
            onEntered: root.entered()
        }
    }
}
