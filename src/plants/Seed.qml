import QtQuick

Image {
    id: root

    readonly property bool paused: parent.paused
    required property var plantComponent
    property bool planting: false
    required property url previewPlantSource
    required property int sunlightConsumption
    readonly property int sunlightSum: parent.sunlightSum

    signal buzzered
    signal plantCanceled
    signal plantStarted(url previewPlantSource, var plantComponent, int sunlightConsumption)

    function plant() {
        if (planting) {
            planting = false;
            numberAnimation.start();
        }
    }

    anchors.verticalCenter: parent.verticalCenter
    asynchronous: true
    mipmap: true
    sourceSize: Qt.size(width, height)
    width: height / 140 * 100

    Rectangle {
        id: shallowCurtain

        anchors.fill: parent
        color: '#000000'
        opacity: 0.5
        visible: !parent.enabled || curtain.height > 0 || parent.sunlightSum < parent.sunlightConsumption
    }
    Rectangle {
        id: curtain

        color: '#000000'
        height: 0
        opacity: 0.8
        width: parent.width

        NumberAnimation {
            id: numberAnimation

            duration: 7500
            paused: running && root.paused
            properties: 'height'
            target: curtain
            to: 0
        }
    }
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        enabled: parent.enabled

        onClicked: {
            if (!planting && !shallowCurtain.visible) {
                curtain.height = parent.height;
                planting = true;
                parent.plantStarted(parent.previewPlantSource, parent.plantComponent, parent.sunlightConsumption);
            } else if (planting) {
                curtain.height = 0;
                planting = false;
                parent.plantCanceled();
            } else
                parent.buzzered();
        }
    }
}
