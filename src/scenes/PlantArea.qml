import QtQuick

Column {
    required property size gameSceneSize
    property var plantComponent: null

    signal planted

    Repeater {
        model: 5

        Row {
            Repeater {
                model: 9

                MouseArea {
                    height: gameSceneSize.height * 0.16
                    width: gameSceneSize.width * 0.105
                }
            }
        }
    }
}
