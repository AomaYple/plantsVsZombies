import QtQuick
import QtQuick.Controls
import QtMultimedia

Item {
    id: root

    required property real loadTime

    signal clicked

    Image {
        id: loadBarDirt

        anchors.bottom: parent.bottom
        asynchronous: true
        height: width * (sourceSize.height / sourceSize.width)
        mipmap: true
        source: '../../resources/images/loadBarDirt.png'
        width: parent.width
    }
    Rectangle {
        id: loadBarGrassRectangle

        clip: true
        color: 'transparent'
        height: loadBarGrass.height
        width: 0

        NumberAnimation on width {
            duration: root.loadTime
            to: loadBarGrass.width
        }

        anchors {
            bottom: loadBarDirt.bottom
            bottomMargin: loadBarDirt.height * 0.7
        }
        Image {
            id: loadBarGrass

            asynchronous: true
            height: width * (sourceSize.height / sourceSize.width)
            mipmap: true
            source: '../../resources/images/loadBarGrass.png'
            width: loadBarDirt.width * 0.96
        }
    }
    Image {
        id: sodRollCap

        asynchronous: true
        cache: false
        height: width * (sourceSize.height / sourceSize.width)
        mipmap: true
        source: '../../resources/images/sodRollCap.png'
        width: parent.width * 0.15
        x: -width / 2
        y: 0

        RotationAnimator on rotation {
            duration: root.loadTime
            to: 360
        }
        ScaleAnimator on scale {
            duration: root.loadTime
            to: 0.5
        }
        XAnimator on x {
            duration: root.loadTime
            to: loadBarDirt.width * 0.85

            onStopped: {
                sodRollCap.source = '';
                startButton.enabled = true;
                startButtonText.text = '点击开始！';
                loadFinishedSound.play();
            }
        }
    }
    Button {
        id: startButton

        anchors.centerIn: loadBarDirt
        enabled: false

        background: Rectangle {
            color: 'transparent'
        }
        contentItem: Text {
            id: startButtonText

            color: parent.enabled && parent.hovered ? '#ff0000' : '#ffcf00'
            font.pointSize: loadBarDirt.height > 0 ? loadBarDirt.height * 0.15 : 1
            horizontalAlignment: Text.AlignHCenter
            text: '加载中...'
            verticalAlignment: Text.AlignVCenter
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: root.clicked()
        }
    }
    MediaPlayer {
        id: loadFinishedSound

        source: '../../resources/music/groan.flac'

        audioOutput: AudioOutput {
        }
    }
}
