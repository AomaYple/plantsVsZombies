PeaShooter {
    shadowPosition: Qt.point(width * 0.08, height * 0.55)
    source: '../../resources/plants/repeater' + (zombieCount > 0 ? 'Shooting.gif' : '.gif')
    type: PlantType.Type.Repeater
}
