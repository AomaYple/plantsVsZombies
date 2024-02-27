import QtQuick
import QtMultimedia

Item {
    id: root

    signal triggered

    function forceActiveFocus() {
        mouseArea.forceActiveFocus();
    }

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: '../../resources/images/button.png'
        sourceSize: Qt.size(width, height)

        Text {
            anchors.centerIn: parent
            color: '#008000'
            text: '菜单'

            font {
                bold: true
                pointSize: height > 0 ? height * 12 : 1
            }
        }
        MouseArea {
            id: mouseArea

            function trigger() {
                sound.play();
                root.triggered();
            }

            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            Keys.onEscapePressed: trigger()
            onClicked: trigger()

            MediaPlayer {
                id: sound

                source: '../../resources/sounds/pause.flac'

                audioOutput: AudioOutput {
                }
            }
        }
    }
}
