import QtQuick

Image {
    required property int sunlightConsumption
    readonly property int sunlightSum: parent.sunlightSum

    signal buzzered
    signal sunlightDecreased(int count)

    anchors.verticalCenter: parent.verticalCenter
    asynchronous: true
    enabled: parent.enabled
    height: parent.height * 0.84
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
            paused: running && !parent.enabled
            properties: 'height'
            target: curtain
            to: 0
        }
    }
    MouseArea {
        anchors.fill: parent
        cursorShape: shallowCurtain.visible ? Qt.ArrowCursor : Qt.PointingHandCursor
        enabled: parent.enabled

        onClicked: {
            if (shallowCurtain.visible)
                parent.buzzered();
            else {
                curtain.height = parent.height;
                numberAnimation.start();
                parent.sunlightDecreased(parent.sunlightConsumption);
            }
        }
    }
}
