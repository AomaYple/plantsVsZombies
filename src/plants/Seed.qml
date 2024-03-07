import QtQuick

Image {
    property bool planting: false
    required property int sunlightConsumption
    readonly property int sunlightSum: parent.sunlightSum

    signal buzzered
    signal plantCanceled
    signal plantStarted(url previewPlantSource)
    signal planted
    signal sunlightDecreased(int count)

    anchors.verticalCenter: parent.verticalCenter
    asynchronous: true
    enabled: parent.enabled
    height: parent.height * 0.84
    mipmap: true
    sourceSize: Qt.size(width, height)
    width: height / 140 * 100

    onPlanted: {
        planting = false;
        sunlightDecreased(sunlightConsumption);
        numberAnimation.start();
    }

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
            paused: running && !parent.enabled
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
                parent.plantStarted('../../resources/plants/sunflower.png');
            } else if (planting) {
                curtain.height = 0;
                planting = false;
                parent.plantCanceled();
            } else
                parent.buzzered();
        }
    }
}
