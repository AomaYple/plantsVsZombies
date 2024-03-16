import QtQml

Plant {
    property int zombieCount: 0

    lifeValue: 65
    shadowHeight: height * 0.55
    shadowPosition: Qt.point(width * 0.07, height * 0.55)
    source: '../../resources/plants/wallNut.gif'
    type: PlantType.Type.WallNut
}
