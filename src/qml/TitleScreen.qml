import QtQuick

Item {
    id: root

    required property real loadTime

    signal clicked

    Image {
        asynchronous: true
        height: parent.height
        mipmap: true
        source: '../../resources/images/titleScreen.png'
        width: parent.width

        LoadBar {
            loadTime: root.loadTime
            width: parent.width * 0.3

            onClicked: root.clicked()

            anchors {
                bottom: parent.bottom
                bottomMargin: parent.height * 0.1
                horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
