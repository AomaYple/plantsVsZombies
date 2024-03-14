import QtQuick
import QtMultimedia

Item {
    readonly property alias shoveling: mouseArea.shoveling

    signal clicked

    visible: false
    width: height / 72 * 70
    y: 0

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: rootPath + '/resources/scenes/shovelBank.png'
        sourceSize: Qt.size(width, height)
    }
    MouseArea {
        id: mouseArea

        property bool shoveling: true

        anchors.fill: parent
        cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
        enabled: parent.enabled

        onClicked: {
            shoveling = !shoveling;
            soundEffect.play();
            parent.clicked();
        }
    }
    SoundEffect {
        id: soundEffect

        source: rootPath + '/resources/sounds/shovel.wav'
    }
}
