import QtQuick
import QtMultimedia

Column {
    id: column

    readonly property var plantContainer: Array(5).fill(null).map(() => Array(9).fill(null))
    property url previewPlantSource: ''
    required property bool shoveling
    required property size subPlantAreaSize

    signal planted(rect property, MouseArea subPlantArea)
    signal shovelled

    function playPlant() {
        const index = Math.round(Math.random());
        switch (index) {
        case 0:
            plant0.play();
            break;
        case 1:
            plant1.play();
            break;
        }
    }

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
                            column.playPlant();
                            column.planted(Qt.rect(plantX, plantY, width * 0.9, height * 0.9), mouseArea);
                        } else if (column.shoveling && column.plantContainer[index[0]][index[1]]) {
                            column.plantContainer[index[0]][index[1]].shovel();
                            column.playPlant();
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
        id: plant0

        source: '../../resources/sounds/plant0.wav'
    }

    SoundEffect {
        id: plant1

        source: '../../resources/sounds/plant1.wav'
    }
}
