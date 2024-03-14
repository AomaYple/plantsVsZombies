import QtQuick

Item {
    required property real cooldownTime
    required property bool paused
    readonly property alias planting: mouseArea.planting
    property alias source: image.source
    required property int sunlightConsumption
    required property int sunlightSum

    signal buzzered
    signal plantCanceled
    signal plantStarted

    function plant() {
        if (mouseArea.planting) {
            mouseArea.planting = false;
            numberAnimation.start();
        }
    }

    width: height / 140 * 100

    Image {
        id: image

        anchors.fill: parent
        asynchronous: true
        mipmap: true
        sourceSize: Qt.size(width, height)
    }
    Rectangle {
        id: curtain

        anchors.fill: parent
        color: '#000000'
        opacity: 0.5
        visible: !parent.enabled || deepCurtain.height > 0 || parent.sunlightSum < parent.sunlightConsumption
    }
    Rectangle {
        id: deepCurtain

        color: '#000000'
        opacity: 0.8
        width: parent.width
    }
    NumberAnimation {
        id: numberAnimation

        duration: root.cooldownTime
        paused: running && root.paused
        properties: 'height'
        target: deepCurtain
        to: 0
    }
    MouseArea {
        id: mouseArea

        property bool planting: false

        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        enabled: parent.enabled

        onClicked: {
            if (!planting && !curtain.visible) {
                deepCurtain.height = height;
                planting = true;
                parent.plantStarted();
            } else if (planting) {
                deepCurtain.height = 0;
                planting = false;
                parent.plantCanceled();
            } else
                parent.buzzered();
        }
    }
}
