import QtQuick
import QtMultimedia

Column {
    id: root

    property var plantContainer: Array(5).fill(null).map(() => Array(9).fill(null))
    property url previewPlantSource
    required property bool shoveling
    required property size subPlantAreaSize

    signal eradicated
    signal planted(rect properties, var subPlantAreaId)

    Repeater {
        model: 5

        Row {
            readonly property int columnIndex: index

            Repeater {
                model: [[parent.columnIndex, 0], [parent.columnIndex, 1], [parent.columnIndex, 2], [parent.columnIndex, 3], [parent.columnIndex, 4], [parent.columnIndex, 5], [parent.columnIndex, 6], [parent.columnIndex, 7], [parent.columnIndex, 8]]

                MouseArea {
                    id: mouseArea

                    readonly property var index: modelData

                    height: root.subPlantAreaSize.height
                    hoverEnabled: true
                    width: root.subPlantAreaSize.width

                    onClicked: {
                        if (previewPlant.visible) {
                            const plantX = root.x + index[1] * width;
                            const plantY = root.y + index[0] * height;
                            const plantWidth = width * 0.9;
                            const plantHeight = height * 0.9;
                            soundEffect.play();
                            root.planted(Qt.rect(plantX, plantY, plantWidth, plantHeight), mouseArea);
                        } else if (root.shoveling && root.plantContainer[index[0]][index[1]]) {
                            root.plantContainer[index[0]][index[1]].shovel();
                            soundEffect.play();
                            root.eradicated();
                        }
                    }

                    PreviewPlant {
                        id: previewPlant

                        anchors.centerIn: parent
                        height: parent.height * 0.9
                        opacity: 0.3
                        source: root.previewPlantSource
                        visible: parent.containsMouse && source.toString() !== '' && !root.plantContainer[parent.index[0]][parent.index[1]]
                    }
                }
            }
        }
    }
    SoundEffect {
        id: soundEffect

        source: rootPath + '/resources/sounds/plant.wav'
    }
}
