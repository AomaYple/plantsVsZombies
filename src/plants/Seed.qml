import QtQuick

Image {
    id: root

    property bool paused: parent.paused
    required property int sunlightConsumption
    property int sunlightSum: parent.sunlightSum

    signal buzzered
    signal sunlightDecreased(int count)

    anchors.verticalCenter: parent.verticalCenter
    asynchronous: true
    height: parent.height * 0.84
    mipmap: true
    sourceSize: Qt.size(width, height)
    width: height / 140 * 100

    Rectangle {
        id: shallowCurtain

        anchors.fill: parent
        color: '#000000'
        opacity: 0.5
        visible: curtain.height > 0 || parent.sunlightSum < parent.sunlightConsumption
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
        cursorShape: shallowCurtain.visible ? Qt.ArrowCursor : Qt.PointingHandCursor

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
