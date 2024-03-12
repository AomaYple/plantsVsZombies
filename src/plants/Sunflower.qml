import QtQuick
import "../scenes" as Scenes

Item {
    id: root

    readonly property int lifeValue: 300
    property alias paused: animatedImage.paused
    required property bool shoveling
    readonly property int type: PlantType.Type.Sunflower

    signal sunlightProduced

    width: height

    Scenes.Shadow {
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height * 0.5
        y: parent.height * 0.6
    }
    AnimatedImage {
        id: animatedImage

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        opacity: parent.shoveling ? 0.8 : 1
        source: rootPath + '/resources/plants/sunflower.gif'
        sourceSize: Qt.size(width, height)
    }
    Scenes.SuspendableTimer {
        interval: 15000
        paused: running && parent.paused
        repeat: true
        running: true

        onTriggered: numberAnimation.start()
    }
    Rectangle {
        id: rectangle

        anchors.horizontalCenter: parent.horizontalCenter
        color: '#ffff00'
        height: parent.height * 0.6
        opacity: 0
        radius: height / 2
        width: height
        y: parent.height * 0.15
    }
    NumberAnimation {
        id: numberAnimation

        duration: 1000
        paused: running && root.paused
        properties: 'opacity'
        target: rectangle
        to: 0.5

        onFinished: if (to === 0.5) {
            to = 0;
            start();
            root.sunlightProduced();
        } else
            to = 0.5
    }
}
