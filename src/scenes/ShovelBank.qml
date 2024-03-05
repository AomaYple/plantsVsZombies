import QtQuick
import QtMultimedia

Item {
    id: root

    property bool shoveling: false

    signal clicked

    anchors.left: seedBank.right
    height: width / 70 * 72
    visible: false
    width: parent.width * 0.09
    y: 0

    Image {
        anchors.fill: parent
        asynchronous: true
        mipmap: true
        source: '../../resources/scenes/shovelBank.png'
        sourceSize: Qt.size(width, height)

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                shovel.play();
                root.clicked();
            }

            SoundEffect {
                id: shovel

                source: '../../resources/sounds/shovel.wav'
            }
        }
    }
}
