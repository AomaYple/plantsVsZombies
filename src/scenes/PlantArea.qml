import QtQuick
import QtMultimedia
import "../js/common.js" as Common

Column {
    id: column

    property var plantContainer: Array(5).fill(null).map(() => Array(9).fill(null))
    required property url previewPlantSource
    required property bool shoveling
    required property size subPlantAreaSize

    signal planted(rect property, var subPlantAreaId)
    signal shovelled

    Repeater {
        model: 5

        Row {
            readonly property int columnIndex: index

            Repeater {
                model: [[parent.columnIndex, 0], [parent.columnIndex, 1], [parent.columnIndex, 2], [parent.columnIndex, 3], [parent.columnIndex, 4], [parent.columnIndex, 5], [parent.columnIndex, 6], [parent.columnIndex, 7], [parent.columnIndex, 8]]

                MouseArea {
                    id: mouseArea

                    readonly property var index: modelData

                    height: column.subPlantAreaSize.height
                    hoverEnabled: true
                    width: column.subPlantAreaSize.width

                    onClicked: {
                        if (previewPlant.visible) {
                            const plantX = column.x + index[1] * width;
                            const plantY = column.y + index[0] * height;
                            const plantWidth = width * 0.9;
                            const plantHeight = height * 0.9;
                            soundEffect.play();
                            column.planted(Qt.rect(plantX, plantY, plantWidth, plantHeight), mouseArea);
                        } else if (column.shoveling && column.plantContainer[index[0]][index[1]]) {
                            column.plantContainer[index[0]][index[1]].lifeValue = 0;
                            soundEffect.play();
                            column.shovelled();
                        }
                    }

                    PreviewPlant {
                        id: previewPlant

                        anchors.centerIn: parent
                        height: parent.height * 0.9
                        opacity: 0.3
                        source: column.previewPlantSource
                        visible: parent.containsMouse && source.toString() !== '' && !column.plantContainer[parent.index[0]][parent.index[1]]
                    }
                }
            }
        }
    }

    SoundEffect {
        id: soundEffect

        source: '../../resources/sounds/plant' + Common.getRandomInt(0, 1) + '.wav'
    }
}
