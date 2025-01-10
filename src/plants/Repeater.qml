import QtQml

PeaShooter {
    shadowPosition: Qt.point(width * 0.08, height * 0.55)
    source: '../../res/plants/' + (zombieCount > 0 ? 'shootingR' : 'r') + 'epeater.gif'
    type: PlantType.Type.Repeater
}
