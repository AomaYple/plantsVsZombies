import QtQuick

Image {
    id: root

    function addSunlight() {
        sunlightCount.text = (parseInt(sunlightCount.text) + 25).toString();
    }
    function emerge() {
        yAnimator.start();
    }

    asynchronous: true
    height: parent.height * 0.145
    mipmap: true
    source: '../../resources/scenes/seedBank.png'
    sourceSize: Qt.size(width, height)
    width: height / 87 * 446
    x: parent.width * 0.01
    y: -height

    Text {
        id: sunlightCount

        color: '#000000'
        text: '50'
        x: parent.width * 0.085 - width / 2
        y: parent.height * 0.82 - height / 2

        font {
            bold: true
            pointSize: Math.max(parent.height * 0.1, 1)
        }
    }
    YAnimator {
        id: yAnimator

        duration: 500
        target: root
        to: 0
    }
}
