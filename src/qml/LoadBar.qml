import QtQuick
import QtQuick.Controls

Item {
    id: root

    required property real loadTime

    signal clicked

    Image {
        id: loadBarDirt

        anchors.bottom: parent.bottom
        asynchronous: true
        height: parent.height * 0.7
        mipmap: true
        source: '../../resources/images/loadBarDirt.png'
        width: parent.width
    }
    Rectangle {
        id: loadBarGrassRectangle

        clip: true
        color: 'transparent'
        height: parent.height - loadBarDirt.height
        width: 0

        NumberAnimation on width {
            duration: root.loadTime
            to: loadBarDirt.width
        }

        anchors {
            bottom: loadBarDirt.bottom
            bottomMargin: loadBarDirt.height * 0.7
        }
        Image {
            asynchronous: true
            height: parent.height
            mipmap: true
            source: '../../resources/images/loadBarGrass.png'
            width: loadBarDirt.width * 0.97
        }
    }
    Image {
        id: sodRollCap

        asynchronous: true
        cache: false
        height: width
        mipmap: true
        source: '../../resources/images/sodRollCap.png'
        width: parent.width * 0.15
        x: 0
        y: (loadBarDirt.y + loadBarGrassRectangle.height - height) / 2

        RotationAnimator on rotation {
            duration: root.loadTime
            to: 360
        }
        ScaleAnimator on scale {
            duration: root.loadTime
            to: 0.4
        }
        XAnimator on x {
            duration: root.loadTime
            to: loadBarDirt.width * 0.9

            onStopped: {
                sodRollCap.source = '';
                startButtonLoader.active = true;
            }
        }
    }
    Loader {
        id: startButtonLoader

        active: false
        anchors.centerIn: loadBarDirt
        asynchronous: true

        sourceComponent: Button {
            background: Rectangle {
                color: 'transparent'
            }
            contentItem: Text {
                color: parent.hovered ? '#ff0000' : '#ffffff'
                font.pointSize: loadBarDirt.height * 0.15
                horizontalAlignment: Text.AlignHCenter
                text: '点击开始'
                verticalAlignment: Text.AlignVCenter
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: root.clicked()
            }
        }
    }
}
