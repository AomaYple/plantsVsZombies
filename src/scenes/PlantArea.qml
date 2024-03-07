import QtQuick

Row {
    id: root

    required property Item gameScene

    enabled: false
    x: parent.width * 0.025
    y: parent.height * 0.14

    Repeater {
        model: 9

        Column {
            Repeater {
                model: 5

                MouseArea {
                    enabled: root.enabled
                    height: gameScene.height * 0.165
                    width: gameScene.width * 0.105
                }
            }
        }
    }
}
