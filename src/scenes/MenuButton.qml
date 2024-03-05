import QtQuick
import QtMultimedia

Item {
    id: root

    signal triggered

    anchors.right: parent.right
    height: width / 291 * 109
    visible: false
    width: parent.width * 0.15
    y: 0

    Keys.onEscapePressed: mouseArea.trigger()

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: '../../resources/scenes/button.png'
        sourceSize: Qt.size(width, height)

        Text {
            anchors.centerIn: parent
            color: '#008000'
            text: '菜单'

            font {
                bold: true
                pointSize: height > 0 ? height * 7 : 1
            }
        }
        MouseArea {
            id: mouseArea

            function trigger() {
                pauseSound.play();
                root.triggered();
            }

            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: trigger()

            SoundEffect {
                id: pauseSound

                source: '../../resources/sounds/pause.wav'
            }
        }
    }
}
