import QtQml

PeaShooter {
    peaComponent: Qt.createComponent('SnowPea.qml', Component.Asynchronous)
    source: '../../resources/plants/snowPeaShooter' + (zombieCount > 0 ? 'Shooting.gif' : '.gif')
    type: PlantType.Type.SnowPeaShooter
}
